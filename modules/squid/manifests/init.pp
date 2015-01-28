# Setup a basic squid server
class squid {
	include squid::package
	include squid::config
	include squid::service
}
