if $ipaddress_enp0s8 { $ipaddr = $ipaddress_enp0s8 }
else { $ipaddr = $ipaddress }
openiosds::namespace {'OPENIO':
  ns             => 'OPENIO',
  conscience_url => "VAGRANT_MAIN_VM:6000",
  zookeeper_url  => "VAGRANT_MAIN_VM:6005",
  oioproxy_url   => "VAGRANT_MAIN_VM:6006",
  eventagent_url => "beanstalk://VAGRANT_MAIN_VM:6014",
}
openiosds::conscienceagent {'conscienceagent-4':
  num       => 4,
  ns        => 'OPENIO',
}
openiosds::meta2 {'meta2-4':
  num       => 4,
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => 6000,
}
openiosds::rawx {'rawx-4':
  num       => 4,
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => 6001,
}
openiosds::rdir {'rdir-4':
  num       => 4,
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  port      => 6010,
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-4':
  num => 4,
  ns  => 'OPENIO',
}
