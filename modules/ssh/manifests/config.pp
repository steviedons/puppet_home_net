class ssh::config($sshd_config_source = "puppet:///modules/ssh/etc/ssh/sshd_config") {
# file { "/etc/ssh/sshd_config":
#  owner   => "root",
#    group   => "root",
#    mode    => 0644,
#    source  => $sshd_config_source,
#    require => Class["ssh::install"],
#    notify  => Service["ssh"],
#  }
  file { "/home/steve/.ssh/id_rsa":
    owner   => "steve",
    group   => "steve",
    mode    => 0600,
    source  => "puppet:///modules/ssh/ssh_host_rsa_key",
    require => Class["ssh::install"],
    notify  => Service["ssh"],
  }
  file { "/home/steve/.ssh/id_rsa.pub":
    owner   => "steve",
    group   => "steve",
    mode    => 0644,
    source  => "puppet:///modules/ssh/ssh_host_rsa_key.pub",
    require => Class["ssh::install"],
    notify  => Service["ssh"],
  }
    ssh_authorized_key { 'steve_ssh':
      user => 'steve',
      type => 'rsa',
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC1Qumt9tDkO0EYLwfb1x/HXFHG+CPSfsAOnOItZQ4JtRYozoZI1408deSOUfLp4P14aBOaOj3FclPYMBYJS5Kzoem59v3ycRspS0cZVK2Zsq6z2vRcodUJ/8nNPykd1zGlftFzFXiQ9/RyDV/TGwRqmhHiIJE7gPiMBU7ihPCOFh+h8TYDvxoln+yyBpzOWj2WpZ8DwIfeWLZG3NlEeKScpoBtIz206sFcZ6cn2goYbQQGGVErIs/gBV6W3gi4yOybtxnX5CYQHCTI4d9i0NL000Oo5aw6GuHbtNDk2dt1cCj8QWMSfSO9qasP9qBwy6afG+PZOGERy/WoSLgxpZi/',
    }
}