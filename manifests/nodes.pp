node 'calisto' {
	file { '/etc/motd':
		content => "This system is managed by Puppet, have fun........\n",
	}
	package { 'git':
		ensure => installed,
	}
	ssh_authorized_key { 'steve_ssh':
		user => 'steve',
		type => 'rsa',
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC4xcnE3ASezAqYwqVd/E3sZse94OnjMESOdDdj1vRgGQjL7jWUDxTnN5dJqTqpG8kYZD/vj+VgSQrrnJWvjMHuS+w4aeh7ZLMHzNGOAInzSnyYj89dHNy9tpuzNSNRARuyxaKbI+75u/WkoWcLzjN9eaZpSkD67wX/zX7gE+QdkiKZKL/Cw8yBDflNfo6nJ8cg3J9QJxCKNVZxf9Xoqp9MsAXIsrlKyzoDkRxbY3OBZsVObW7MPexCsbwE9QDP2uJzwLr6rzB5fNJF2QeQBEtR/Q1vKJtWpj7IeZ9NxwosJNv80cICxzeFlh6SaMEfAG9L3f78HgJrjwzISgUxIRGp',
	}
	cron { 'Back up system':
    		command => 'rsync -az --exclude-from=/home/steve/exclude_file.txt / /media/backup/calisto-backup',
		user => root,
		hour => '3',
    		minute  => '00',
  	}
        cron { 'Set up the puppet crontab':
                command => '/usr/local/bin/pull-updates',
                user => steve,
                minute  => '10',
        }
	include squid
	include hosts
	include resolv
}
node 'titan' {
        file { '/etc/motd':
                content => "This system is managed by Puppet, have fun........\n",
        }
#	package { 'git':
#		ensure => installed,
#	}
        cron { 'Back up system':
                command => 'rsync -az --exclude-from=/home/steve/exclude_file.txt / /media/backup/titan-backup/manjaro',
		user => root,
		hour => '20',
                minute  => '00',
        }
	cron { 'Set up the puppet crontab':
                command => '/usr/local/bin/pull-updates',
		user => steve,
                minute  => '10',
        }
	include hosts
	include resolv
}
node 'raspbmc' {
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
        cron { 'Set up the puppet crontab':
                command => '/usr/local/bin/pull-updates',
                user => git,
                minute  => '10',
        }
        ssh_authorized_key { 'steve_ssh':
                user => 'steve',
                type => 'rsa',
                key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC4xcnE3ASezAqYwqVd/E3sZse94OnjMESOdDdj1vRgGQjL7jWUDxTnN5dJqTqpG8kYZD/vj+VgSQrrnJWvjMHuS+w4aeh7ZLMHzNGOAInzSnyYj89dHNy9tpuzNSNRARuyxaKbI+75u/WkoWcLzjN9eaZpSkD67wX/zX7gE+QdkiKZKL/Cw8yBDflNfo6nJ8cg3J9QJxCKNVZxf9Xoqp9MsAXIsrlKyzoDkRxbY3OBZsVObW7MPexCsbwE9QDP2uJzwLr6rzB5fNJF2QeQBEtR/Q1vKJtWpj7IeZ9NxwosJNv80cICxzeFlh6SaMEfAG9L3f78HgJrjwzISgUxIRGp',
        }
        include hosts
        include resolv
}
