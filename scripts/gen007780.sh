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
# on 18-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22545
#Group Title: GEN007780
#Rule ID: SV-26920r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007780
#Rule Title: The system must not have 6to4 enabled.
#
#Vulnerability Discussion: 6to4 is an IPv6 transition mechanism that 
#involves tunneling IPv6 packets encapsulated in IPv4 packets on an 
#ad-hoc basis. This is not a preferred transition strategy and 
#increases the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the system for any active 6to4 tunnels without specific remote addresses.
# ip tun list | grep "remote any" | grep "ipv6/ip"
#If any results are returned the "tunnel" is the first field.
#If any results are returned, this is a finding.

#Fix Text: Disable the active 6to4 tunnel.
# ip link set <tunnel> down
#Add this command to a startup script, or remove the configuration creating the tunnel.   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN007700: Disable IPv6 to IPv4 Tunnels'
echo '==================================================='

#Global Variables#
PDI=GEN007780

#Start-Lockdown
for TUNDEV in `ip tun list | awk -F ':' '/remote any/ && /ipv6\/ip/{print $1}'`;do
	ip link set $TUNDEV down &>/dev/null
	ip tun del name $TUNDEV &>/dev/null
done

grep 'IPV6_AUTOTUNNEL' /etc/sysconfig/network > /dev/null
if [ $? -eq 0 ]; then
	grep 'IPV6_AUTOTUNNEL=yes' /etc/sysconfig/network > /dev/null
	if [ $? -eq 0 ]; then
		sed -i -e 's/IPV6_AUTOTUNNEL=yes/IPV6_AUTOTUNNEL=no/g' /etc/sysconfig/network
	fi
else
	echo "# Adding for STIG check $PDI" >> /etc/sysconfig/network
	echo "IPV6_AUTOTUNNEL=no" >> /etc/sysconfig/network
fi

