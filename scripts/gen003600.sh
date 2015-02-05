#!/bin/sh

## (GEN003600: CAT II) The SA will ensure network parameters are securely set.
echo '==================================================='
echo ' Patching GEN003600: Set network parameters' 
echo '==================================================='
sed -i "/net\.ipv4\.conf\.default\.rp_filter/ c\net.ipv4.conf.default.rp_filter = 1" /etc/sysctl.conf &>/dev/null
sed -i "/net\.ipv4\.conf\.default\.accept_source_route/ c\net.ipv4.conf.default.accept_source_route = 0" /etc/sysctl.conf &>/dev/null

`grep -q tcp_max_syn_backlog /etc/sysctl.conf`
if [ $? -ne 0 ]; then
	echo "net.ipv4.tcp_max_syn_backlog = 1280" >> /etc/sysctl.conf
fi

`grep -q icmp_echo_ignore_broadcasts /etc/sysctl.conf`
if [ $? -ne 0 ]; then
	echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
fi

`grep -q disable_ipv6 /etc/sysctl.conf`
if [ $? -ne 0 ]; then
	echo "" >> /etc/sysctl.conf
	echo "# DISABLE IPV6" >> /etc/sysctl.conf
	echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
fi

`grep -q NETWORKING_IPV6 /etc/sysconfig/network`
if [ $? -ne 0 ]; then
	echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
else
	sed -i "/NETWORKING_IPV6/s/yes/no/" /etc/sysconfig/network
fi

`grep -q IPV6INIT /etc/sysconfig/network`
if [ $? -ne 0 ]; then
	echo "IPV6INIT=no" >> /etc/sysconfig/network
else
	sed -i "/IPV6INIT/s/yes/no/" /etc/sysconfig/network
fi

`grep -q NOZEROCONF /etc/sysconfig/network`
if [ $? -ne 0 ]; then
	echo "NOZEROCONF=yes" >> /etc/sysconfig/network
else
	sed -i "/NOZEROCONF/s/no/yes/" /etc/sysconfig/network
fi

