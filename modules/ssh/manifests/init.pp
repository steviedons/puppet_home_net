# Setup a basic ssh server and keys
class ssh {
	include ssh::install
	include ssh::config
	include ssh::service
}