# Main init.pp for home_net

node 'mimas.steviedons.com' {
	include baseconfig
	include sshd
}
