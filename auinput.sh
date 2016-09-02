#!/usr/bin/expect
spawn docker run -ti --privileged -p 3330-3333:3330-3333 -e "container=docker" dounine/centos-openvpn:1.4 /sbin/init
expect "login:"
send "root\r"
expect "Password:"
send "root\r"
send "systemctl restart iptables.service\r"
send "iptables -F\r"
send "iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT\r"
send "iptables -A FORWARD -s 10.8.0.0/24 -j ACCEPT\r"
send "iptables -A FORWARD -j REJECT\r"
send "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE\r"
send "reset\r"
interact
