#!/bin/bash

echo '==================================================='
echo ' Additional Hardening: Disable Services (CATCH-ALL)'
echo '==================================================='

### Disable Services
OFFSRV="abrt-ccpp abrt-oops abrtd anacron atd apmd autofs avahi-daemon avahi-dnsconfd bluetooth cups dovecot firstboot gpm hidd hplip irda isdn kdump kudzu lm_sensors mcstrans mdmonitor microcode_ctl nfs nfslock portmap procmail portreserve qpidd rpcgssd rpcbind rpcidmap rpcsvcgssd rawdevices readahead_early readahead_later rhnsd restorecond setroubleshoot snmpd squid netfs smb nmb sssd sysstat wpa_supplicant xfs xinetd sendmail"

for SRV in $OFFSRV; do
	if [ `/sbin/chkconfig --list | grep -c $SRV` -gt 0 ]; then
		echo "Disabling $SRV Service."
		/sbin/chkconfig $SRV off &> /dev/null
		/sbin/service $SRV stop &> /dev/null
	fi
done

### Enable Services
ONSRV="postfix iptables"

for SRV in $ONSRV; do
	if [ `/sbin/chkconfig --list | grep -c $SRV` -gt 0 ]; then
		echo "Enabling $SRV Service."
		/sbin/chkconfig $SRV on &> /dev/null
		/sbin/service $SRV start &> /dev/null
	fi
done

# Auditing and Syslog should always be on...
/sbin/chkconfig --level 0123456 auditd on &> /dev/null
/sbin/service auditd start &> /dev/null
/sbin/chkconfig --level 0123456 rsyslog on &> /dev/null
/sbin/service rsyslog start &> /dev/null

### IPv6 - Requires ip6tables
`grep NETWORKING_IPV6 /etc/sysconfig/network | grep -q yes`
if [ $? -eq 0 ]; then
	echo "Enabling ip6tables Service."
	/sbin/chkconfig $SRV on &> /dev/null
	/sbin/service $SRV start &> /dev/null
else
	echo "Disabling ip6tables Service."
	/sbin/chkconfig $SRV off &> /dev/null
	/sbin/service $SRV stop &> /dev/null
fi

### Unsure
UNSURE="pcscd"
