# Main init.pp for home_net

class base {
	file { '/etc/motd':
                content => "This system is managed by Puppet, have fun........\n",
        }
        package { 'git':
                ensure => installed,
        }
   }
   
class dotfiles {
         vcsrepo { '/home/steve/dotfiles':
          ensure => latest,
          provider => git,
          source => 'git@github.com:steviedons/dotfiles.git',
          revision => 'master',
          require => Package["git"],
          identity => '/home/steve/.ssh/id_rsa',
        }   
}

node 'phobos.steviedons.com' {
	include base
	include hosts
	include resolv
	include ssh
        include dotfiles
}
node 'europa.steviedons.com' {
	include base
	include hosts
	include resolv
	include squid
}
node 'metis.steviedons.com' {
    include base
    include hosts
    include resolv
}
node 'mate.steviedons.com' {
	include base
}
