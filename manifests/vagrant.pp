if $ipaddress_enp0s8 { $ipaddr = $ipaddress_enp0s8 }
else { $ipaddr = $ipaddress }
class {'openiosds':}
openiosds::namespace {'OPENIO':
  ns             => 'OPENIO',
  conscience_url => "${ipaddr}:6000",
  oioproxy_url   => "${ipaddr}:6006",
  eventagent_url => "beanstalk://${ipaddr}:6008",
  zookeeper_url  => "${ipaddr}:6005",
}
openiosds::zookeeper {'zookeeper-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6005',
  bootstrap => true,
}
openiosds::account {'account-1':
  num        => '1',
  ns         => 'OPENIO',
  ipaddress  => $ipaddr,
  port       => '6009',
  redis_host => $ipaddr,
  redis_port => '6011',
}
openiosds::conscience {'conscience-1':
  num                   => '1',
  ns                    => 'OPENIO',
  service_update_policy => 'meta2=KEEP|3|0|;meta1=REPLACE;sqlx=KEEP|1|1|',
  storage_policy        => 'UNSAFETHREECOPIES',
  meta2_max_versions    => '0',
  ipaddress             => $ipaddr,
  port                  => '6000',
}
openiosds::meta0 {'meta0-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6001',
}
openiosds::meta0 {'meta0-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6071',
}
openiosds::meta0 {'meta0-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6081',
}
openiosds::meta1 {'meta1-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6002',
}
openiosds::meta1 {'meta1-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6072',
}
openiosds::meta1 {'meta1-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6082',
}
openiosds::meta2 {'meta2-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6003',
}
openiosds::meta2 {'meta2-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6073',
}
openiosds::meta2 {'meta2-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6083',
}
openiosds::rawx {'rawx-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6004',
}
openiosds::rawx {'rawx-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6074',
}
openiosds::rawx {'rawx-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6084',
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-1':
  num => '1',
  ns  => 'OPENIO',
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-2':
  num => '2',
  ns  => 'OPENIO',
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-3':
  num => '3',
  ns  => 'OPENIO',
}
openiosds::rdir {'rdir-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6010',
}
openiosds::rdir {'rdir-2':
  num       => '2',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6070',
}
openiosds::rdir {'rdir-3':
  num       => '3',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6080',
}
openiosds::oioeventagent {'oio-event-agent-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6008',
}
openiosds::oioproxy {'oioproxy-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => '0.0.0.0',
  port      => '6015',
}
openiosds::redis {'redis-0':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6011',
}
openiosds::conscienceagent {'conscienceagent-1':
  num => '1',
  ns  => 'OPENIO',
}
openiosds::beanstalkd {'beanstalkd-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => '6014',
}
