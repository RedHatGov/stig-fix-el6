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


#Rule Title: The SSH daemon must not permit Kerberos authentication unless needed.
#
#Vulnerability Discussion: Kerberos authentication for SSH is often implemented using GSSAPI. 
#If Kerberos is enabled through SSH, the SSH daemon provides a means of access to the system's 
#Kerberos implementation. Vulnerabilities in the system's Kerberos implementation may then be 
#subject to exploitation. To reduce the attack surface of the system, the Kerberos authentication 
#mechanism within SSH must be disabled for systems not using this capability.
#
#
#Responsibility: System Administrator
#
#Check Content: 
#Ask the SA if Kerberos authentication is used by the system. If it is, this is not applicable.
#
#Check the SSH daemon configuration for the KerberosAuthentication setting.
# grep -i KerberosAuthentication /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, or the setting is set to "yes", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and set (add if necessary) an "KerberosAuthentication" directive set to "no".   

#Global Variables#
PDI=ssh_KerberosAuthentication_disabled

#Start-Lockdown
if [ `grep -c "^KerberosAuthentication" /etc/ssh/sshd_config` -gt 0 ]; then
	egrep '^KerberosAuthentication.*yes' /etc/ssh/sshd_config > /dev/null
	if [ $? -eq 0 ]; then
		sed -i "/^KerberosAuthentication/ c\KerberosAuthentication no" /etc/ssh/sshd_config
		service sshd restart &>/dev/null
	fi
else
	echo "KerberosAuthentication no" >> /etc/ssh/sshd_config
	service sshd restart &>/dev/null
fi
