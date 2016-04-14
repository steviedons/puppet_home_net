# Install, configure and startup the sshd to disallow root user login
class sshd {
	include sshd::install
	include sshd::config
	include sshd::service
}
