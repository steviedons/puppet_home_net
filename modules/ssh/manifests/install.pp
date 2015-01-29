class ssh::install {
  package { "ssh":
    ensure => present,
  }
}