# Setup a basic ssh server and keys
class squid {
	include ssh::install
	include ssh::config
	include ssh::service
}