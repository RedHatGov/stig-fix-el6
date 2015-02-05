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
#Group ID (Vulid): V-22486
#Group Title: GEN005537
#Rule ID: SV-26782r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005537
#Rule Title: The SSH daemon must use privilege separation.
#
#Vulnerability Discussion: SSH daemon privilege separation causes the SSH process
#to drop root privileges when not needed, which would decrease the impact of software vulnerabilities in the unprivileged section.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the SSH daemon configuration for the UsePrivilegeSeparation setting.
# grep -i UsePrivilegeSeparation /etc/ssh/sshd_config | grep -v '^#'
#If the setting is not present, or not set to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add or edit the "UsePrivilegeSeparation" setting value to "yes".   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005537: PrivlageSeperation on SSHD'
echo '==================================================='

#Global Variables#
PDI=GEN005537

#Start-Lockdown
USERPRIV=$( grep -i UsePrivilegeSeparation /etc/ssh/sshd_config | grep -v '^#' | wc -l )
MODECORRECT=$( grep -i "UsePrivilegeSeparation no" /etc/ssh/sshd_config | grep -v '^#' | wc -l )
if [ $USERPRIV -eq 0 ]; then
	echo "#Added for DISA GEN005537" >> /etc/ssh/sshd_config
	echo "UsePrivilegeSeparation yes" >> /etc/ssh/sshd_config
else
	if [ $MODECORRECT -eq 1 ]; then
		sed -i 's/UsePrivilegeSeparation no/UsePrivilegeSeparation yes/g' /etc/ssh/sshd_config
	fi
fi
