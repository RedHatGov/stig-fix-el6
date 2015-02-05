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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22485
#Group Title: GEN005536
#Rule ID: SV-26781r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005536
#Rule Title: The SSH daemon must perform strict mode checking of home directory configuration files.
#
#Vulnerability Discussion: If other users have access to modify user-specific SSH configuration files, they may be able to log into the system as another user.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the SSH daemon configuration for the StrictModes setting.
# grep -i StrictModes /etc/ssh/sshd_config | grep -v '^#'
#If the setting is not present, or not set to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add or edit the "PubkeyAuthentication" setting value to "yes".    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005536: Enable Strict Mode SSHD'
echo '==================================================='

#Global Variables#
PDI=GEN005536
WHATMODE=$( grep -i StrictModes /etc/ssh/sshd_config | grep -v '^#' | wc -l )
MODECORRECT=$( grep -i "StrictModes no" /etc/ssh/sshd_config | grep -v '^#' | wc -l )
#Start-Lockdown
if [ $WHATMODE -eq 0 ]; then
	echo "#Added for DISA GEN005536" >> /etc/ssh/sshd_config
	echo "StrictModes yes" >> /etc/ssh/sshd_config
else
	if [ $MODECORRECT -eq 1 ]; then
		sed -i 's/StrictModes no/StrictModes yes/g' /etc/ssh/sshd_config
	fi
fi
