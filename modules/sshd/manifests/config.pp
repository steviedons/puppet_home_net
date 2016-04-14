class sshd::config($sshd_config_source = "puppet:///modules/sshd/sshd_config") {
  file { "/etc/ssh/sshd_config":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => $sshd_config_source,
    require => Class["sshd::install"],
    notify  => Service["ssh"],
  }
}
