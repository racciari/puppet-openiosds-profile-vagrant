openiosds::conscience {'conscience-1':
  num                   => '1',
  ns                    => 'OPENIO',
  service_update_policy => 'meta2=KEEP|3|0|;meta1=REPLACE;sqlx=KEEP|1|1|',
  storage_policy        => 'UNSAFETHREECOPIES',
  meta2_max_versions    => '0',
  ipaddress             => "${ipaddress_enp0s8}",
  port                  => '6000',
  conscience_url        => "${ipaddress_enp0s8}:6000",
  zookeeper_url         => "${ipaddress_enp0s8}:6011",
  oioproxy_url          => "${ipaddress}:6012",
  eventagent_url        => "tcp://${ipaddress}:6013",
}
