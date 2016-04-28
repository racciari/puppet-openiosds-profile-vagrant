VAGRANT_SWIFT_IP=$2

# Check IP argument
if [ $# -ne 2 ]; then
  echo "Error: Argument is missing."
  echo "Usage: $0 <ip_address>"
  exit 1
fi
# Check if IP is valid
$IPCALC -s -c "$VAGRANT_SWIFT_IP"
if [ $? -ne 0 ]; then
  echo "Error: IP $VAGRANT_SWIFT_IP is invalid."
  echo "Usage: $0 $1 <ip_address>"
  exit 1
fi

# Retrieving demo user tenant ID
$SED -i -e "s@VAGRANT_SWIFT_IP@$VAGRANT_SWIFT_IP@g" /usr/share/puppet/modules/openiosds/profiles/vagrant-ext-pydio/conf/keystonerc_demo
source /usr/share/puppet/modules/openiosds/profiles/vagrant-ext-pydio/conf/keystonerc_demo
VAGRANT_TENANT_ID=$(/bin/keystone token-get | /bin/awk '/tenant_id/ {print $4}')

# Switching vagrant main IP and tenant ID in the Pydio database configuration
$SED -i -e "s@VAGRANT_SWIFT_IP@$VAGRANT_SWIFT_IP@g" -e "s@VAGRANT_TENANT_ID@$VAGRANT_TENANT_ID@g" /usr/share/puppet/modules/openiosds/profiles/vagrant-ext-pydio/conf/pydiodb.sql

# Load Pydio database
/bin/mysql pydiodb </usr/share/puppet/modules/openiosds/profiles/vagrant-ext-pydio/conf/pydiodb.sql

# Initialize the demo container
/usr/bin/yum -y install python-swiftclient
/usr/bin/swift post demo

