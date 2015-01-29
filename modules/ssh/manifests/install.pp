class ssh::install {
  package { "sshd":
    ensure => present,
  }
}