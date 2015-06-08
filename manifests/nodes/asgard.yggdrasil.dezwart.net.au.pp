# Ostensibly an experiment with Puppet.
# As there are no innocents, names haven't been changed

# TODO: Use role includes and heira.
node 'asgard.yggdrasil.dezwart.net.au' {
  $install_packages = [ 'curl',
    'deborphan',
    'multitail',
    'strace',
    'git',
    'puppet',
    'sudo',
    'sysstat',
    ]

  package { $install_packages:
    ensure  => installed,
  }

  $uninstall_packages = [ 'nano' ]

  package { $uninstall_packages:
    ensure  => purged,
  }

  $default_domain_name = 'yggdrasil.dezwart.net.au'
  $dynamic_dns_reverse_zone = '1.168.192'

  class { 'squid':
    localnet_src              => '10.0.0.0/24',
    cache_replacement_policy  => 'heap LFUDA',
    cache_dir_type            => 'aufs',
    cache_dir_size            => 524288,
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

  #class { 'rsyslog':
  #  remote  => true,
  #}
}

# vim: set ts=2 sw=2 sts=2 tw=0 et:
