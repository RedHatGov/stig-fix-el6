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
# on 20-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22583
#Group Title: GEN008540
#Rule ID: SV-26975r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008540
#Rule Title: The system's local firewall must implement a deny-all, allow-by-exception policy.
#
#Vulnerability Discussion: A local firewall protects the system from 
#exposing unnecessary or undocumented network services to the local 
#enclave. If a system within the enclave is compromised, firewall 
#protection on an individual system continues to protect it from attack.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the firewall rules for a default deny rule.
# iptables --list
#If there is no default deny rule, this is a finding.
#
#Fix Text: Edit /etc/sysconfig/iptables and add a default deny rule.
#Restart the iptable service
# service iptables restart
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008540

#Start-Lockdown
grep '^\-A INPUT' /etc/sysconfig/iptables | tail -n 1 | egrep '\-A INPUT \-j REJECT \-\-reject-with icmp-host-prohibited' > /dev/null
if [ $? -ne 0 ]; then
	echo '==================================================='
	echo ' Patching GEN008540: Disable All Traffic Not '
	echo '                     Explicity Allowed by iptables'
	echo '==================================================='
	iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited > /dev/null
	service iptables save &>/dev/null
fi 

