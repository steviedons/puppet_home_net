# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  
  package { ['epel-release', 'vim-enhanced', 'htop', 'tree', 'unzip', 'git', 'docker']:
    ensure => present,
  }

  group { 'wheel':
    ensure => present,
  }
  user { 'steve':
    ensure     => present,
    comment    => 'Stephen Donovan',
    home       => '/home/steve',
    groups     => ['wheel','docker'],
    password   => '$6$9oEtZVi1$MEHcx4PbHsu81cDb2EJPElBOMHDQkIg4Bjn.hifQ8aFVnT9tFrVqbvJXl6DJ5ncJC0m5wuzMf61u/qtDXmp291'
    managehome => true,
  }

  ssh_authorized_key { 'steve_ssh':
    user    => 'steve',
    type    => 'rsa',
    key     => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCY7dN61s6H57fYGV2THhvTzhi0xXQLd59UTSmKc8D+Vl7v7OzBFNL43VfdzsXk539ylo6jrWjeI4pmIL5oBRBIf/X57DW/c33TBYhePfEJC7XiQLibWpgo0dz4uoa0iFBGE10UymoNMsuGYIFnzXF0UXQ7LlT/f1rdZp3iv7P0B4rU5HtxLI30eAlXvG62ODxSXCn7xvsrkvR7PHC/LPxKe3vqQfwoQ2qg8F1jXbtNKQtQuDaT/PdvkjkhD/KM+YQH9sLuYyngaTSjbu6BMpMWaRwlvvM0byCbKd+gzhXJohENHm8+qsSjNjZjbyFUoyYthwBC8ER2WHLNe4tj2u9N steve@titan',
    require => User['steve'],
  }

  service { 'yum-cron':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['yum-cron'],
  }

}
