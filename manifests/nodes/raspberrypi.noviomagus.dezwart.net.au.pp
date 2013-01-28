node 'raspberrypi.noviomagus.dezwart.net.au' {
  $install_packages = [ 'curl',
    'deborphan',
    'telnet',
    'collectd' ]

  package { $install_packages:
    ensure  => installed,
  }

  class { 'apt':
    http_proxy => 'http://proxy.noviomagus.dezwart.net.au:3128/',
  }

  class { 'rsyslog':
    forwarders  => [ 'logs.noviomagus.dezwart.net.au' ],
  }

  class { 'ntp':
    servers => [ 'ntp.noviomagus.dezwart.net.au' ],
  }
}

# vim: set ts=2 sw=2 sts=2 tw=0 et:
