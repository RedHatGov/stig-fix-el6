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
# on 12-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22665
#Group Title: GEN005590
#Rule ID: SV-26807r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005590
#Rule Title: The system must not be running any routing protocol daemons, unless the system is a router.
#
#Vulnerability Discussion: Routing protocol daemons are typically used on routers to exchange network topology information with other routers. If this software is used when not required, system network information may be unnecessarily transmitted across the network.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for any running routing protocol daemons.
# ps ax | egrep '(ospf|route|bgp|zebra|quagga)'
#If any routing protocol daemons are listed, this is a finding.
#
#Fix Text: Disable any routing protocol daemons.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005590

#Start-Lockdown
echo '==================================================='
echo ' Patching GEN005590: Disable Routing Protocol Daemons'
echo '==================================================='
for SERVICE in bgpd ospf6d ospfd ripd ripngd zebra; do
	chkconfig --list $SERVICE 2>/dev/null | grep ':on' > /dev/null
	if [ $? -eq 0 ]; then
		service $SERVICE stop &>/dev/null
		chkconfig $SERVICE off &>/dev/null
	fi
done
