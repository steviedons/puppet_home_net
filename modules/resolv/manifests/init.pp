# Manage rexolv.conf
class resolv {
  file { '/etc/resolv.conf':
        owner  => root,
        group  => root,
        source => 'puppet:///modules/resolv/resolv.conf',
        }
}


