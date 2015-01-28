class squid::config {
  File {
	owner => 'root',
	group => 'root',
  }

  file { '/etc/squid/squid.conf':
	ensure => present,
        source => 'puppet:///modules/squid/squid.conf',
	require => Class['squid::package'],
        notify => Class['squid::service'],
  }
}
