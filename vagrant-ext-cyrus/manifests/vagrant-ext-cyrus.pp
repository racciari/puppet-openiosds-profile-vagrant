openiosds::namespace {'OPENIO':
    ns             => 'OPENIO',
    conscience_url => "VAGRANT_MAIN_VM:6000",
    zookeeper_url  => "VAGRANT_MAIN_VM:6005",
    oioproxy_url   => "VAGRANT_MAIN_VM:6006",
    eventagent_url => "beanstalk://VAGRANT_MAIN_VM:6014",
}
