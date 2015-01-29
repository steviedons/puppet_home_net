class ssh::service {
  service { "sshd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Class["ssh::install"],
  }
}