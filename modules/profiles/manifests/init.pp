# == Class: profiles
#
# Full description of class profiles here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profiles':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class profiles {

}

class profiles::linux::mariadb {

}

class profiles::linux::webserver {

  class { 'apache': }
  class { 'firewalld': }

  apache::vhost { 'test.steviedons.com':
    port          => '80',
    docroot       => '/var/www/test',
    docroot_owner => 'apache',
    docroot_group => 'apache',
  }

  file { '/var/www/test/index.html':
    content => "This is a test of profile::linux::apache :)",
    require => Apache::Vhost['test.steviedons.com'],
  }

  firewalld_port { 'Open port 80 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 80,
    protocol => 'tcp',
  }

}
