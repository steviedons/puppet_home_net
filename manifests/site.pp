# Main init.pp for home_net

class base {
	file { '/etc/motd':
                content => "This system is managed by Puppet, have fun........\n",
        }
        package { 'git':
                ensure => installed,
        }
        ssh_authorized_key { 'steve_ssh':
                user => 'steve',
                type => 'rsa',
                key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC1Qumt9tDkO0EYLwfb1x/HXFHG+CPSfsAOnOItZQ4JtRYozoZI1408deSOUfLp4P14aBOaOj3FclPYMBYJS5Kzoem59v3ycRspS0cZVK2Zsq6z2vRcodUJ/8nNPykd1zGlftFzFXiQ9/RyDV/TGwRqmhHiIJE7gPiMBU7ihPCOFh+h8TYDvxoln+yyBpzOWj2WpZ8DwIfeWLZG3NlEeKScpoBtIz206sFcZ6cn2goYbQQGGVErIs/gBV6W3gi4yOybtxnX5CYQHCTI4d9i0NL000Oo5aw6GuHbtNDk2dt1cCj8QWMSfSO9qasP9qBwy6afG+PZOGERy/WoSLgxpZi/',
        }

node 'phobos.steviedons.com' {
	include base
	include hosts
	include resolv
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
