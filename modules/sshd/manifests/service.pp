class sshd::service {
  service { "sshd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Class["sshd::install"],
  }
}
