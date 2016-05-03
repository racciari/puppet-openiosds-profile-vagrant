VAGRANT_MAIN_VM=$2

# Check IP argument
if [ $# -ne 2 ]; then
  echo "Error: Argument is missing."
  echo "Usage: $0 <ip_address>"
  exit 1
fi
# Check if IP is valid
$IPCALC -s -c "$VAGRANT_MAIN_VM"
if [ $? -ne 0 ]; then
  echo "Error: IP $VAGRANT_MAIN_VM is invalid."
  echo "Usage: $0 $1 <ip_address>"
  exit 1
fi

# Switching vagrant main IP into manifests
$SED -i -e "s@VAGRANT_MAIN_VM@$VAGRANT_MAIN_VM@g" /usr/share/puppet/modules/openiosds/profiles/vagrant-ext-swift/manifests/*.pp

# Install required packages
/usr/bin/yum -y install puppet memcached python-swiftclient

# Install Keystone puppet module
/usr/bin/puppet module install stackforge-keystone

# Configure memcached
/usr/bin/systemctl enable memcached.service
/usr/bin/systemctl start memcached.service

# Default authentification variables for Keystone
echo "export OS_TENANT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=DEMO_PASS
export OS_AUTH_URL=http://localhost:5000/v2.0" \
  > ~openio/keystonerc_demo
