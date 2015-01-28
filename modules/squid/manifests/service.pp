class squid::service {
  service { 'squid':
        ensure => running,
        enable => true,
        require => Package['squid'],
  }
}
