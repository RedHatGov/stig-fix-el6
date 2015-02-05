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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechonlogy-llc.com)
# on 06-Feb-2012 to only run fix when needed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22456
#Group Title: GEN005501
#Rule ID: SV-26749r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005501
#Rule Title: The SSH client must be configured to only use the SSHv2 protocol.
#
#Vulnerability Discussion: SSHv1 is not a DoD-approved protocol and has many well-known vulnerability exploits.
#Exploits of the SSH client could provide access to the system with the privileges of the user running the client.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check the SSH client configuration for allowed protocol versions.
# grep -i protocol /etc/ssh/ssh_config | grep -v '^#'
#If the returned protocol configuration allows versions less than 2, this is a finding.
#
#Fix Text: Edit the /etc/ssh/ssh_config file and add or edit a "Protocol" configuration line that does not allow versions less than 2.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005501

echo '==================================================='
echo ' Patching GEN005501: Ensure SSHv2 is used on client'
echo '==================================================='

#Start-Lockdown
grep -q Protocol /etc/ssh/ssh_config 2>/dev/null
if [ $? -eq 0 ]; then
	egrep '^Protocol.*1' /etc/ssh/ssh_config 2>/dev/null
	if [ $? -eq 0 ]; then
		sed -i "/^Protocol/ c\Protocol 2" /etc/ssh/ssh_config
	fi
else
	echo "Protocol 2" >> /etc/ssh/ssh_config
fi
