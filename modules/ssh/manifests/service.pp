class ssh::service {
  service { "ssh":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Class["ssh::install"],
  }
}