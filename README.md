puppet-tree
===========

Git sub-module organised puppet tree.

Designed for use within a home office environment, where environment is a single server running Debian 6 "Lenny".

This tree and sub-modules are an experiment with Puppet using git as the VCS.

But how?
--------

By the power of trimethylxanthine!

    git clone git@github.com:dezwart/puppet-tree.git
    cd puppet-tree
    git submodule init
    git submodule update

But I wants a node!
-------------------

Here is a sample node that uses most of the sub-modules.

    node 'host.domain' {
        $default_domain_name = 'domain'
        $dynamic_dns_key = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa='
        $dynamic_dns_reverse_zone = '0.0.10'

        class { 'squid':
            localnet_src                => '10.0.0.0/8',
            cache_replacement_policy    => 'heap LFUDA',
            cache_dir_type              => 'aufs',
            cache_dir_size              => 4096,
            maximum_object_size         => '256 MB',
            cache_swap_low              => 95,
            cache_swap_high             => 100,
            cachemgr_passwd             => 'XXXXXXXX',
            log_fqdn                    => 'on',
        }

        class { 'apt':
            http_proxy => 'http://localhost:3128/',
        }

        class { 'bind':
            forwarders                  => [ '172.16.0.1', '172.16.0.2' ],
            dynamic_dns_key             => "$dynamic_dns_key",
            dynamic_dns_forward_zone    => "$default_domain_name",
            dynamic_dns_reverse_zone    => "$dynamic_dns_reverse_zone",
        }

        class { 'resolv':
            domain_name     => $default_domain_name,
            name_servers    => [ '127.0.0.1' ],
        }

        class { 'rsyslog':
            remote  => true,
        }

        class { 'ntp':
            servers => [ 'ntp.upstream.domain' ],
        }

        class { 'isc-dhcp':
            interfaces                  => [ 'ethX' ],
            domain_name                 => $default_domain_name,
            domain_name_servers         => [ '10.0.0.1' ],
            authoritative               => true,
            subnet                      => '10.0.0.0',
            netmask                     => '255.0.0.0',
            range_start                 => '10.0.0.2',
            range_end                   => '10.255.255.253',
            routers                     => [ '10.255.255.254' ],
            ddns_update_style           => 'interim',
            dynamic_dns_key             => "$dynamic_dns_key",
            dynamic_dns_forward_zone    => "$default_domain_name",
            dynamic_dns_reverse_zone    => "$dynamic_dns_reverse_zone",
            dynamic_dns_ns_master       => 'localhost',
        }

        class { 'arpwatch':
        }
    }
