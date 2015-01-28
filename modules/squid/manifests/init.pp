# Manage nginx webserver
class squid {
  package { 'squid':
    ensure => installed,
  }
  service { 'squid':
	ensure => running,
	enable => true,
	require => Package['squid'],
  }
  file { '/etc/squid/squid.conf':
	source => 'puppet:///modules/squid/squid.conf',
	notify => Service['squid'],
  }
}
