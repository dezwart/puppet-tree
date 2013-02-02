# Ostensibly an experiment with Puppet.
# As there are no innocents, names haven't been changed

# TODO: Use role includes and heira.
node 'asgard.noviomagus.dezwart.net.au' {
  $install_packages = [ 'curl',
    'deborphan',
    'telnet',
    'multitail',
    'lm-sensors',
    'build-essential',
    'cacti',
    'collectd',
    'smokeping',
    'squid-cgi',
    'exim4',
    'rubygems' ]

  package { $install_packages:
    ensure  => installed,
  }

  $uninstall_packages = [ 'nano' ]

  package { $uninstall_packages:
    ensure  => purged,
  }

  $install_gems = [ 'puppet-lint',
    'rake' ]

  package { $install_gems:
    ensure    => installed,
    provider  => gem,
  }

  $default_domain_name = 'noviomagus.dezwart.net.au'
  $dynamic_dns_reverse_zone = '1.168.192'

  class { 'squid':
    localnet_src              => '192.168.1.0/24',
    cache_replacement_policy  => 'heap LFUDA',
    cache_dir_type            => 'aufs',
    cache_dir_size            => 262144,
    maximum_object_size       => '8 GB',
    cache_swap_low            => 99,
    cache_swap_high           => 100,
    cachemgr_passwd           => 'REDACTED',
    log_fqdn                  => 'on',
    snmp_port                 => 3401,
  }

  class { 'apt':
    http_proxy => 'http://localhost:3128/',
  }

  class { 'bind':
    forwarders  => [ '211.29.152.116',
      '198.142.0.51',
      '211.29.132.12' ],
  }

  bind::zone { $default_domain_name:
    serial                => '2013020201',
    refresh               => 300,
    failed_refresh_retry  => 300,
    expire                => 300,
    minimum               => 300,
    ttl                   => 300,
    records               => ["@\tIN\tNS\t${fqdn}.",
      "network\tIN\tA\t192.168.1.0",
      "yggdrasil\tIN\tA\t192.168.1.1",
      "gateway\tIN\tCNAME\tyggdrasil",
      "asgard\tIN\tA\t192.168.1.254",
      "ns\tIN\tCNAME\tasgard",
      "dhcp\tIN\tCNAME\tasgard",
      "ntp\tIN\tCNAME\tasgard",
      "proxy\tIN\tCNAME\tasgard",
      "logs\tIN\tCNAME\tasgard",
      "collectd\tIN\tCNAME\tasgard",
      "bifrost\tIN\tA\t192.168.1.2",
      "helheim\tIN\tA\t192.168.1.3",
      "jos-ipad\tIN\tA\t192.168.1.98",
      "groenestraat\tIN\tA\t192.168.1.99",
      "midgard\tIN\tA\t192.168.1.100",
      "svartalfaheim\tIN\tA\t192.168.1.101",
      "niflheim\tIN\tA\t192.168.1.102",
      "muspelheim\tIN\tA\t192.168.1.103",
      "alfheim\tIN\tA\t192.168.1.104",
      "raspberrypi\tIN\tA\t192.168.1.105",
      "dynamic-200\tIN\tA\t192.168.1.200",
      "dynamic-201\tIN\tA\t192.168.1.201",
      "dynamic-202\tIN\tA\t192.168.1.202",
      "dynamic-203\tIN\tA\t192.168.1.203",
      "dynamic-204\tIN\tA\t192.168.1.204",
      "dynamic-205\tIN\tA\t192.168.1.205",
      "dynamic-206\tIN\tA\t192.168.1.206",
      "dynamic-207\tIN\tA\t192.168.1.207",
      "dynamic-208\tIN\tA\t192.168.1.208",
      "dynamic-209\tIN\tA\t192.168.1.209",
      "dynamic-210\tIN\tA\t192.168.1.210",
      "dynamic-211\tIN\tA\t192.168.1.211",
      "dynamic-212\tIN\tA\t192.168.1.212",
      "dynamic-213\tIN\tA\t192.168.1.213",
      "dynamic-214\tIN\tA\t192.168.1.214",
      "dynamic-215\tIN\tA\t192.168.1.215",
      "dynamic-216\tIN\tA\t192.168.1.216",
      "dynamic-217\tIN\tA\t192.168.1.217",
      "dynamic-218\tIN\tA\t192.168.1.218",
      "dynamic-219\tIN\tA\t192.168.1.219",
      "dynamic-220\tIN\tA\t192.168.1.220",
      "dynamic-221\tIN\tA\t192.168.1.221",
      "dynamic-222\tIN\tA\t192.168.1.222",
      "dynamic-223\tIN\tA\t192.168.1.223",
      "dynamic-224\tIN\tA\t192.168.1.224",
      "dynamic-225\tIN\tA\t192.168.1.225",
      "dynamic-226\tIN\tA\t192.168.1.226",
      "dynamic-227\tIN\tA\t192.168.1.227",
      "dynamic-228\tIN\tA\t192.168.1.228",
      "dynamic-229\tIN\tA\t192.168.1.229",
      "dynamic-230\tIN\tA\t192.168.1.230",
      "dynamic-231\tIN\tA\t192.168.1.231",
      "dynamic-232\tIN\tA\t192.168.1.232",
      "dynamic-233\tIN\tA\t192.168.1.233",
      "dynamic-234\tIN\tA\t192.168.1.234",
      "dynamic-235\tIN\tA\t192.168.1.235",
      "dynamic-236\tIN\tA\t192.168.1.236",
      "dynamic-237\tIN\tA\t192.168.1.237",
      "dynamic-238\tIN\tA\t192.168.1.238",
      "dynamic-239\tIN\tA\t192.168.1.239",
      "dynamic-240\tIN\tA\t192.168.1.240",
      "dynamic-241\tIN\tA\t192.168.1.241",
      "dynamic-242\tIN\tA\t192.168.1.242",
      "dynamic-243\tIN\tA\t192.168.1.243",
      "dynamic-244\tIN\tA\t192.168.1.244",
      "dynamic-245\tIN\tA\t192.168.1.245",
      "dynamic-246\tIN\tA\t192.168.1.246",
      "dynamic-247\tIN\tA\t192.168.1.247",
      "dynamic-248\tIN\tA\t192.168.1.248",
      "dynamic-249\tIN\tA\t192.168.1.249",
      "dynamic-250\tIN\tA\t192.168.1.250",
      "dynamic-251\tIN\tA\t192.168.1.251",
      "dynamic-252\tIN\tA\t192.168.1.252",
      "dynamic-253\tIN\tA\t192.168.1.253",
      "broadcast\tIN\tA\t192.168.1.255"],
  }

  bind::zone { '1.168.192.in-addr.arpa':
    serial                => '2013020201',
    refresh               => 300,
    failed_refresh_retry  => 300,
    expire                => 300,
    minimum               => 300,
    ttl                   => 300,
    records               => ["@\tIN\tNS\t${fqdn}.",
      "0\tIN\tPTR\tnetwork.noviomagus.dezwart.net.au.",
      "1\tIN\tPTR\tyggdrasil.noviomagus.dezwart.net.au.",
      "2\tIN\tPTR\tbifrost.noviomagus.dezwart.net.au.",
      "3\tIN\tPTR\thelheim.noviomagus.dezwart.net.au.",
      "98\tIN\tPTR\tjos-ipad.noviomagus.dezwart.net.au.",
      "99\tIN\tPTR\tgroenestraat.noviomagus.dezwart.net.au.",
      "100\tIN\tPTR\tmidgard.noviomagus.dezwart.net.au.",
      "101\tIN\tPTR\tsvartalfaheim.noviomagus.dezwart.net.au.",
      "102\tIN\tPTR\tniflheim.noviomagus.dezwart.net.au.",
      "103\tIN\tPTR\tmuspelheim.noviomagus.dezwart.net.au.",
      "104\tIN\tPTR\talfheim.noviomagus.dezwart.net.au.",
      "105\tIN\tPTR\traspberrypi.noviomagus.dezwart.net.au.",
      "200\tIN\tPTR\tdynamic-200.noviomagus.dezwart.net.au.",
      "201\tIN\tPTR\tdynamic-201.noviomagus.dezwart.net.au.",
      "202\tIN\tPTR\tdynamic-202.noviomagus.dezwart.net.au.",
      "203\tIN\tPTR\tdynamic-203.noviomagus.dezwart.net.au.",
      "204\tIN\tPTR\tdynamic-204.noviomagus.dezwart.net.au.",
      "205\tIN\tPTR\tdynamic-205.noviomagus.dezwart.net.au.",
      "206\tIN\tPTR\tdynamic-206.noviomagus.dezwart.net.au.",
      "207\tIN\tPTR\tdynamic-207.noviomagus.dezwart.net.au.",
      "208\tIN\tPTR\tdynamic-208.noviomagus.dezwart.net.au.",
      "209\tIN\tPTR\tdynamic-209.noviomagus.dezwart.net.au.",
      "210\tIN\tPTR\tdynamic-210.noviomagus.dezwart.net.au.",
      "211\tIN\tPTR\tdynamic-211.noviomagus.dezwart.net.au.",
      "212\tIN\tPTR\tdynamic-212.noviomagus.dezwart.net.au.",
      "213\tIN\tPTR\tdynamic-213.noviomagus.dezwart.net.au.",
      "214\tIN\tPTR\tdynamic-214.noviomagus.dezwart.net.au.",
      "215\tIN\tPTR\tdynamic-215.noviomagus.dezwart.net.au.",
      "216\tIN\tPTR\tdynamic-216.noviomagus.dezwart.net.au.",
      "217\tIN\tPTR\tdynamic-217.noviomagus.dezwart.net.au.",
      "218\tIN\tPTR\tdynamic-218.noviomagus.dezwart.net.au.",
      "219\tIN\tPTR\tdynamic-219.noviomagus.dezwart.net.au.",
      "220\tIN\tPTR\tdynamic-220.noviomagus.dezwart.net.au.",
      "221\tIN\tPTR\tdynamic-221.noviomagus.dezwart.net.au.",
      "222\tIN\tPTR\tdynamic-222.noviomagus.dezwart.net.au.",
      "223\tIN\tPTR\tdynamic-223.noviomagus.dezwart.net.au.",
      "224\tIN\tPTR\tdynamic-224.noviomagus.dezwart.net.au.",
      "225\tIN\tPTR\tdynamic-225.noviomagus.dezwart.net.au.",
      "226\tIN\tPTR\tdynamic-226.noviomagus.dezwart.net.au.",
      "227\tIN\tPTR\tdynamic-227.noviomagus.dezwart.net.au.",
      "228\tIN\tPTR\tdynamic-228.noviomagus.dezwart.net.au.",
      "229\tIN\tPTR\tdynamic-229.noviomagus.dezwart.net.au.",
      "230\tIN\tPTR\tdynamic-230.noviomagus.dezwart.net.au.",
      "231\tIN\tPTR\tdynamic-231.noviomagus.dezwart.net.au.",
      "232\tIN\tPTR\tdynamic-232.noviomagus.dezwart.net.au.",
      "233\tIN\tPTR\tdynamic-233.noviomagus.dezwart.net.au.",
      "234\tIN\tPTR\tdynamic-234.noviomagus.dezwart.net.au.",
      "235\tIN\tPTR\tdynamic-235.noviomagus.dezwart.net.au.",
      "236\tIN\tPTR\tdynamic-236.noviomagus.dezwart.net.au.",
      "237\tIN\tPTR\tdynamic-237.noviomagus.dezwart.net.au.",
      "238\tIN\tPTR\tdynamic-238.noviomagus.dezwart.net.au.",
      "239\tIN\tPTR\tdynamic-239.noviomagus.dezwart.net.au.",
      "240\tIN\tPTR\tdynamic-240.noviomagus.dezwart.net.au.",
      "241\tIN\tPTR\tdynamic-241.noviomagus.dezwart.net.au.",
      "242\tIN\tPTR\tdynamic-242.noviomagus.dezwart.net.au.",
      "243\tIN\tPTR\tdynamic-243.noviomagus.dezwart.net.au.",
      "244\tIN\tPTR\tdynamic-244.noviomagus.dezwart.net.au.",
      "245\tIN\tPTR\tdynamic-245.noviomagus.dezwart.net.au.",
      "246\tIN\tPTR\tdynamic-246.noviomagus.dezwart.net.au.",
      "247\tIN\tPTR\tdynamic-247.noviomagus.dezwart.net.au.",
      "248\tIN\tPTR\tdynamic-248.noviomagus.dezwart.net.au.",
      "249\tIN\tPTR\tdynamic-249.noviomagus.dezwart.net.au.",
      "250\tIN\tPTR\tdynamic-250.noviomagus.dezwart.net.au.",
      "251\tIN\tPTR\tdynamic-251.noviomagus.dezwart.net.au.",
      "252\tIN\tPTR\tdynamic-252.noviomagus.dezwart.net.au.",
      "253\tIN\tPTR\tdynamic-253.noviomagus.dezwart.net.au.",
      "254\tIN\tPTR\tasgard.noviomagus.dezwart.net.au.",
      "255\tIN\tPTR\tbroadcst.noviomagus.dezwart.net.au."],
  }

  class { 'rsyslog':
    remote  => true,
  }

  class { 'ntp':
    servers => [ 'ntp.optusnet.com.au' ],
  }

  class { 'isc_dhcp':
    interfaces          => [ 'eth0' ],
    domain_name         => $default_domain_name,
    domain_name_servers => [ '192.168.1.254' ],
    authoritative       => true,
    subnet              => '192.168.1.0',
    netmask             => '255.255.255.0',
    range_start         => '192.168.1.200',
    range_end           => '192.168.1.253',
    routers             => [ '192.168.1.1' ],
  }

  isc_dhcp::host { 'bifrost.noviomagus.dezwart.net.au':
    mac => '00:26:bb:6c:0a:04',
  }

  isc_dhcp::host { 'helheim.noviomagus.dezwart.net.au':
    mac => '20:c9:d0:9c:20:cd',
  }

  isc_dhcp::host { 'jos-ipad.noviomagus.dezwart.net.au':
    mac => 'a4:d1:d2:96:da:54',
  }

  isc_dhcp::host { 'groenestraat.noviomagus.dezwart.net.au':
    mac => '00:1a:a0:8c:96:d0',
  }

  isc_dhcp::host { 'midgard.noviomagus.dezwart.net.au':
    mac => 'c8:bc:c8:93:f7:07',
  }

  isc_dhcp::host { 'svartalfaheim.noviomagus.dezwart.net.au':
    mac => '00:1f:5b:3f:ae:6d',
  }

  isc_dhcp::host { 'niflheim.noviomagus.dezwart.net.au':
    mac => '98:03:d8:a6:16:f5',
  }

  isc_dhcp::host { 'muspelheim.noviomagus.dezwart.net.au':
    mac => '28:6a:ba:5c:2a:bf',
  }

  isc_dhcp::host { 'alfheim.noviomagus.dezwart.net.au':
    mac => '9c:20:7b:92:66:3a',
  }

  isc_dhcp::host { 'raspberrypi.noviomagus.dezwart.net.au':
    mac => 'b8:27:eb:b2:f2:33',
  }

  # Collectd Collection3 package requirements
  # TODO: Turn this in to a module.
  $collection3_package_deps = [ 'apache2',
    'librrds-perl',
    'libconfig-general-perl',
    'libhtml-parser-perl',
    'libregexp-common-perl' ]

  package { $collection3_package_deps:
    ensure  =>  installed,
  }
}

# vim: set ts=2 sw=2 sts=2 tw=0 et:
