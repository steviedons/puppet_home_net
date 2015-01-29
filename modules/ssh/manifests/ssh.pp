class ssh::install {
  package { "ssh":
    ensure => present,
  }
}

class ssh::service {
  service { "ssh":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Class["ssh::install"],
  }
}

class ssh::config($sshd_config_source =
"puppet:///modules/ssh/etc/ssh/sshd_config") {
# file { "/etc/ssh/sshd_config":
#  owner   => "root",
#    group   => "root",
#    mode    => 0644,
#    source  => $sshd_config_source,
#    require => Class["ssh::install"],
#    notify  => Service["ssh"],
#  }
  file { "/etc/ssh/ssh_host_rsa_key":
    owner   => "root",
    group   => "root",
    mode    => 0600,
    source  => "puppet:///private/etc/ssh/ssh_host_rsa_key",
    require => Class["ssh::install"],
    notify  => Service["ssh"],
  }
  file { "/etc/ssh/ssh_host_rsa_key.pub":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///private/etc/ssh/ssh_host_rsa_key.pub",
    require => Class["ssh::install"],
    notify  => Service["ssh"],
  }
}