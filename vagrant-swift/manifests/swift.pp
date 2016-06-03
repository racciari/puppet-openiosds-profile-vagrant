if $ipaddress_enp0s8 { $ipaddr = $ipaddress_enp0s8 }
else { $ipaddr = $ipaddress }

### Install and configure Keystone
class { 'keystone':
  verbose        => True,
  admin_token    => 'KEYSTONE_ADMIN_UUID',
  database_connection => 'sqlite:////var/lib/keystone/keystone.db',
}

# Adds the admin credential to Keystone.
class { 'keystone::roles::admin':
  email        => 'test@openio.io',
  password     => 'ADMIN_PASS',
}

# Installs the Keystone service user endpoints.
class { 'keystone::endpoint':
  public_url   => "http://${ipaddr}:5000",
  admin_url    => "http://${ipaddress}:5000",
  internal_url => "http://${ipaddress}:35357",
  region       => 'localhost-1',
}

# Configure the Swift service into Keystone
keystone_user { 'swift':
  ensure  => present,
  enabled => True,
  password => 'SWIFT_PASS',
}
keystone_user_role { 'swift@services':
  roles  => ['admin'],
  ensure => present
}
keystone_service { 'openio-swift':
  ensure      => present,
  type        => 'object-store',
  description => 'OpenIO SDS swift proxy',
}
keystone_endpoint { 'localhost-1/openio-swift':
   ensure       => present,
   public_url   => "http://${ipaddr}:6007/v1.0/AUTH_%(tenant_id)s",
   admin_url    => "http://${ipaddress}:6007/v1.0/AUTH_%(tenant_id)s",
   internal_url => "http://${ipaddress}:6007/v1.0/AUTH_%(tenant_id)s",
}

# Configure the `demo@demo` tenant and account into Keystone
keystone_tenant { 'demo':
  ensure  => present,
  enabled => True,
}
keystone_user { 'demo':
  ensure  => present,
  enabled => True,
  password => "DEMO_PASS",
}
keystone_role { '_member_':
  ensure => present,
}
keystone_user_role { 'demo@demo':
  roles  => ['admin','_member_'],
  ensure => present
}

### OpenIO namespace
class {'openiosds':}
openiosds::namespace {'OPENIO':
  ns             => 'OPENIO',
  conscience_url => "${ipaddr}:6000",
  oioproxy_url   => "${ipaddr}:6006",
  eventagent_url => "beanstalk://${ipaddr}:6014",
}
openiosds::conscience {'conscience-0':
  ns                    => 'OPENIO',
  service_update_policy => 'meta2=KEEP|3|1|;rdir=KEEP|1|1|user_is_a_service=1',
  storage_policy        => 'SINGLE',
  meta2_max_versions    => '0',
  ipaddress             => $ipaddr,
}
openiosds::account {'account-0':
  ns         => 'OPENIO',
  ipaddress  => $ipaddr,
}
openiosds::meta0 {'meta0-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::meta1 {'meta1-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::meta2 {'meta2-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::rawx {'rawx-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-0':
  ns  => 'OPENIO',
}
openiosds::rdir {'rdir-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::oioeventagent {'oio-event-agent-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::oioproxy {'oioproxy-0':
  ns        => 'OPENIO',
  ipaddress => '0.0.0.0',
}
openiosds::redis {'redis-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
openiosds::conscienceagent {'conscienceagent-0':
  ns  => 'OPENIO',
}
openiosds::beanstalkd {'beanstalkd-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
}
