node 'phobos' {
	file { '/etc/motd':
		content => "This system is managed by Puppet, have fun........\n",
	}
	package { 'git':
		ensure => installed,
	}
	ssh_authorized_key { 'steve_ssh':
		user => 'steve',
		type => 'rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCkP+zxhcAziU8IOIGlZ77dqlqKZSwXajKQCL13M41yqfUdKWi36my9tF9OrELbHgppaIH0IhxuCawtW2WVPl3TneSBAMkXZ/7nKdvYI2iqYZzMUQ6PXivvQ9xvaE3TojfWFE2iZXYy6PxZkfyjtN4z9FRaST6k2AKOpA4lU/Yw0awTbXvHjUrlePi5ahJ4jvjNyUfCF39nuHS++k7q6NG8+oKz66v33z9Dywcim8/G4eMZUmMiFCcp+UsvIJkxeJAiys9qN9urWPYvpQNisY/IJtTT4LCQEj8ZOTPJ2DdfhoFIST/DhakLfM1XQbgrgHNOiwq8CJhiLEkBxjK1DZIl ',
	}
	cron { 'Back up system':
    		command => 'rsync -az --exclude-from=/home/steve/exclude_file.txt / /media/backup/calisto-backup',
		user => root,
		hour => '3',
    		minute  => '00',
  	}
	include hosts
	include resolv
}
node 'europa' {
        file { '/etc/motd':
                content => "This system is managed by Puppet, have fun........\n",
        }
	package { 'git':
		ensure => installed,
	}
        cron { 'Back up system':
                command => 'rsync -az --exclude-from=/home/steve/exclude_file.txt / /media/backup/titan-backup/manjaro',
		user => root,
		hour => '20',
                minute  => '00',
        }
	include hosts
	include resolv
}
node 'metis' {
        file { '/etc/motd':
                content => "This system is managed by Puppet, have fun........\n",
        }
        package { 'git':
                ensure => installed,
        }
	user { 'steve':
		ensure => present,
		comment => 'Stephen Donovan',
		home => '/home/steve',
		managehome => true,
		shell => '/bin/bash',
		gid => 'adm',
	}
        ssh_authorized_key { 'steve_ssh':
                user => 'steve',
                type => 'rsa',
                key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCkP+zxhcAziU8IOIGlZ77dqlqKZSwXajKQCL13M41yqfUdKWi36my9tF9OrELbHgppaIH0IhxuCawtW2WVPl3TneSBAMkXZ/7nKdvYI2iqYZzMUQ6PXivvQ9xvaE3TojfWFE2iZXYy6PxZkfyjtN4z9FRaST6k2AKOpA4lU/Yw0awTbXvHjUrlePi5ahJ4jvjNyUfCF39nuHS++k7q6NG8+oKz66v33z9Dywcim8/G4eMZUmMiFCcp+UsvIJkxeJAiys9qN9urWPYvpQNisY/IJtTT4LCQEj8ZOTPJ2DdfhoFIST/DhakLfM1XQbgrgHNOiwq8CJhiLEkBxjK1DZIl ',
        }
        include hosts
        include resolv
}
