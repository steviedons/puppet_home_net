# Manage nginx webserver
class hosts {
  file { '/etc/hosts':
        owner => root,
        group => root,
        source => 'puppet:///modules/hosts/hosts',
  }
}

