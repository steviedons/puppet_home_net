# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  
  package { ['epel-release', 'vim-enhanced', 'htop', 'tree', 'unzip', 'git', 'fish']:
    ensure => present;
  }

  file { '/etc/motd':
    content => "This system is managed by Puppet, have fun........\n",
  }

  user { 'steve':
    ensure      => present,
    comment     => 'Stephen Donovan',
    home        => '/home/steve',
    managehome  => true,
    shell       => '/bin/fish',
    password   => '$6$9oEtZVi1$MEHcx4PbHsu81cDb2EJPElBOMHDQkIg4Bjn.hifQ8aFVnT9tFrVqbvJXl6DJ5ncJC0m5wuzMf61u/qtDXmp291',
    require     => Package['fish'],
  }

  ssh_authorized_key { 'steve_ssh':
    user    => 'steve',
    type    => 'rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC3VId/OYnb/PfduaH0+zj59Dez8v/cRglz7bmN8r562xWoUz7+lTlGA78sSRrU275UGtd8tp+RW5xCtFW0oQcqfApiR2r1SxUesS4Nmc2lQyX9QaJiLIA9/HgoZAQ8QQFNtjiuSi71LjFoCn8iRf8Be1swFSklGnj5cuEjHmzGUBSSK7X64A4QevB5rVPnPbrTVggdASiE2SlI1FFLyIrctIy4ckadGUm+qiL7eDPXg2I0ULO6hw3qPasQoglC4+MkXpYRN3822SrJUSrJ3/6qLsXmGUZx8FWgz5ujbi88Z5/t/4OXhBYjFzC7VQiyXE0OHOiqHvQFYBbOPVEvPRZf',
    require => User['steve'],
  }
}
