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
# on 20-Feb-2012 to add a check before running the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22582
#Group Title: GEN008520
#Rule ID: SV-26973r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008520
#Rule Title: The system must employ a local firewall.
#
#Vulnerability Discussion: A local firewall protects the system from exposing unnecessary or undocumented network services to the local enclave. If a system within the enclave is compromised, firewall protection on an individual system continues to protect it from attack.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the system is using a local firewall.
# chkconfig --list iptables
#If the service is not "on" in the standard runlevel (ordinarily 3 or 5), this is a finding.
#
#Fix Text: Enable the system's local firewall.
# chkconfig iptables on
# service iptables start: 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008520

#Start-Lockdown
chkconfig --list iptables | grep ':on' > /dev/null
if [ $? -ne 0 ]; then
	echo '==================================================='
	echo ' Patching GEN008520: Enable iptables Firewall '
	echo '==================================================='
	chkconfig iptables on &> /dev/null
	service iptables start &>/dev/null
fi
