openiosds::account {'account-1':
  num        => '1',
  ns         => 'OPENIO',
  ipaddress  => "${ipaddress_enp0s8}",
  port       => '6014',
  redis_host => '127.0.0.1',
  redis_port => '6379',
}
