#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 18-Feb-2012 to add a few checks before running the fixes and to add an
# entry to the /etc/sysconfig/network if none already exists.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22541
#Group Title: GEN007700
#Rule ID: SV-26216r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007700
#Rule Title: The IPv6 protocol handler must not be bound to the network stack unless needed.
#
#Vulnerability Discussion: IPv6 is the next version of the Internet protocol. Binding this protocol to the network stack increases the attack surface of the host.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the IPv6 protocol handler is bound to the network stack, and the system does not need IPv6, this is a finding.
#
#Fix Text: Remove the capability to use IPv6 protocol handler.
#
#Procedure:
#Edit /etc/sysconfig/network and change
#NETWORKING_IPV6=yes
#to
#NETWORKING_IPV6=no
#
#Edit /etc/modprobe.conf and add these lines (if they're not in it):
#alias net-pf-10 off
#alias ipv6 off
#
#Stop the ipv6tables service by typing:
#service ip6tables stop
#
#Disable the ipv6tables service by typing:
#chkconfig ip6tables off
#
#Remove the ipv6 kernel module
# rmmod ipv6

#Reboot 
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN007700: Disable IPv6'
echo '==================================================='

#updated for RHEL 6 

#Global Variables#
PDI=GEN007700
IPV6=$( cat /etc/sysconfig/network|grep "NETWORKING_IPV6=yes" | wc -l )
#Start-Lockdown

grep NETWORKING_IPV6 /etc/sysconfig/network > /dev/null
if [ $? -eq 0 ]; then
	if [ $IPV6 -ne 0 ]; then
		sed -i 's/NETWORKING_IPV6=yes/NETWORKING_IPV6=no/g' /etc/sysconfig/network
	fi
else
	echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
fi

chkconfig --list ip6tables | grep ':on' > /dev/null
if [ $? -eq 0 ]; then 
	service ip6tables stop &>/dev/null
	chkconfig ip6tables off &>/dev/null
	rmmod ipv6 &>/dev/null
fi

