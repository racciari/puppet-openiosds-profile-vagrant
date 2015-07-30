openiosds::sdsagent {'sds-agent-0':
}
openiosds::namespace {'OPENIO':
  ns             => 'OPENIO',
  conscience_url => "${ipaddress_enp0s8}:6000",
  zookeeper_url  => "${ipaddress_enp0s8}:6011",
  oioproxy_url   => "${ipaddress}:6012",
  eventagent_url => "tcp://${ipaddress}:6013",
}
openiosds::account {'account-1':
  num        => '1',
  ns         => 'OPENIO',
  ipaddress  => "${ipaddress_enp0s8}",
  port       => '6014',
  redis_default_install => true,
  redis_host => '127.0.0.1',
  redis_port => '6379',
}
openiosds::conscience {'conscience-1':
  num                   => '1',
  ns                    => 'OPENIO',
  service_update_policy => 'meta2=KEEP|3|0|;meta1=REPLACE;sqlx=KEEP|1|1|',
  storage_policy        => 'UNSAFETHREECOPIES',
  meta2_max_versions    => '0',
  ipaddress             => "${ipaddress_enp0s8}",
  port                  => '6000',
}
openiosds::meta0 {'meta0-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => '6001',
}
openiosds::meta1 {'meta1-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => '6002',
}
openiosds::meta1 {'meta1-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6003",
}
openiosds::meta1 {'meta1-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6004",
}
openiosds::meta2 {'meta2-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6005",
}
openiosds::meta2 {'meta2-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6006",
}
openiosds::meta2 {'meta2-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6007",
}
openiosds::oioeventagent {'oio-event-agent-1':
  num  => '1',
  ns   => 'OPENIO',
  port => '6013',
}
openiosds::oioproxy {'oioproxy-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => '0.0.0.0',
  port      => '6012',
}
openiosds::rawx {'rawx-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6008",
}
openiosds::rawx {'rawx-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6009",
}
openiosds::rawx {'rawx-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6010",
}
openiosds::zookeeper {'zookeeper-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6011",
  bootstrap => true,
}
