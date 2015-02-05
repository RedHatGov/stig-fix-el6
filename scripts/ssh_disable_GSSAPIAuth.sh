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


#Rule Title: The SSH daemon must not permit GSSAPI authentication unless needed.
#
#Vulnerability Discussion: GSSAPI authentication is used to provide additional authentication mechanisms to applications. 
#Allowing GSSAPI authentication through SSH exposes the system’s GSSAPI to remote hosts, increasing the attack surface of 
#the system. GSSAPI authentication must be disabled unless needed.
#
#Responsibility: System Administrator
#
#Check Content: 
#Ask the SA if GSSAPI authentication is used for SSH authentication to the system. If so, this is not applicable.
#
#Check the SSH daemon configuration for the GSSAPIAuthentication setting.
# grep -i GSSAPIAuthentication /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, or the setting is set to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and set (add if necessary) a "GSSAPIAuthentication" directive set to "no".   

echo '==================================================='
echo ' Remediation: Disable GSSAPIAuth in SSHD'
echo '==================================================='

#Global Variables#
PDI=ssh_disable_GSSAPIAuth

#Start-Lockdown
if [ `grep -c "^GSSAPIAuthentication" /etc/ssh/sshd_config` -gt 0 ]; then
	egrep '^GSSAPIAuthentication.*yes' /etc/ssh/sshd_config > /dev/null
	if [ $? -eq 0 ]; then
		sed -i "/^GSSAPIAuthentication/ c\GSSAPIAuthentication no" /etc/ssh/sshd_config
		service sshd restart &>/dev/null 
  	fi
else
	echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
	service sshd restarat &>/dev/null
fi

