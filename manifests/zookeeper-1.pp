openiosds::zookeeper {'zookeeper-1':
  num       => '1',
  ns        => 'OPENIO',
  ipaddress => "${ipaddress_enp0s8}",
  port      => "6011",
}
