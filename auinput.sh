#!/usr/bin/expect
spawn docker run -ti --privileged -p 3330-3333:3330-3333 -e "container=docker" dounine/centos-openvpn /sbin/init
expect "login:"
send "root\r"
expect "Password:"
send "root\r"
send "systemctl restart iptables.service\r"
send "iptables -F\r"
send "iptables -t nat -A POSTROUTING -s 10.8.0.0/32 -o eth0 -j MASQUERADE\r"
send "vpn\r"
#send "printf \"\ec\"\r"
send "clear\r"
expect eof
interact
