#!/bin/bash

# Install the RDO repository
/usr/bin/yum -y install centos-release-openstack-mitaka

# Install required packages
/usr/bin/yum -y install puppet memcached python-swiftclient

# Install Keystone puppet module
/usr/bin/puppet module install stackforge-keystone

# Install memcached
/usr/bin/yum -y install memcached
/usr/bin/systemctl enable memcached.service
/usr/bin/systemctl start memcached.service

# Install swift client
/usr/bin/yum -y install python-swiftclient

# Default authentification variables for Keystone
echo "export OS_TENANT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=DEMO_PASS
export OS_AUTH_URL=http://localhost:5000/v2.0" \
  > ~openio/keystonerc_demo
