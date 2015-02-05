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


#Rule Title: The SSH client must not permit GSSAPI authentication unless needed.
#
#Vulnerability Discussion: GSSAPI authentication is used to provide additional authentication mechanisms to applications. 
#Allowing GSSAPI authentication through SSH exposes the system’s GSSAPI to remote hosts, increasing the attack surface of the system. 
#GSSAPI authentication must be disabled unless needed.
#
#Responsibility: System Administrator
#
#Check Content: 
#Check the SSH clients configuration for the GSSAPIAuthentication setting.
# grep -i GSSAPIAuthentication /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the setting is set to "yes", this is a finding.
#
#Fix Text: Edit the SSH client configuration and set (add if necessary) an "GSSAPIAuthentication" directive set to "no".   

echo '==================================================='
echo ' Remediating: Disable GSSAPIAuth in SSH'
echo '==================================================='

#Global Variables#
PDI=GEN005525

#Start-Lockdown
if [ `grep -c "^[^#]*GSSAPIAuthentication" /etc/ssh/ssh_config` -gt 0 ]; then
	egrep 'GSSAPIAuthentication.*yes' /etc/ssh/ssh_config > /dev/null
	if [ $? -eq 0 ]; then
		sed -i "/GSSAPIAuthentication/ c\GSSAPIAuthentication no" /etc/ssh/ssh_config
	fi
else
	echo "#Adding for DISA $PDI" >> /etc/ssh/ssh_config
	echo "GSSAPIAuthentication no" >> /etc/ssh/ssh_config
fi

