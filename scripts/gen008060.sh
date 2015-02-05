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
# on 18-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22559
#Group Title: GEN008060
#Rule ID: SV-26946r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008060
#Rule Title: If the system is using LDAP for authentication or account information the /etc/ldap.conf (or equivalent) file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/ldap.conf
#If the mode of the file is more permissive than 0644, this is a finding.
#
#Fix Text: Change the permissions of the file.
# chmod 0644 /etc/ldap.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008060

#Start-Lockdown
if [ -a "/etc/ldap.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN008060: ldap.conf Permissions'
	echo '==================================================='

	# Pull the actual permissions
	FILEPERMS=`stat -L --format='%04a' /etc/ldap.conf`

	# Break the actual file octal permissions up per entity
	FILESPECIAL=${FILEPERMS:0:1}
	FILEOWNER=${FILEPERMS:1:1}
	FILEGROUP=${FILEPERMS:2:1}
	FILEOTHER=${FILEPERMS:3:1}

	# Run check by 'and'ing the unwanted mask(7133)
	if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]; then
		chmod u-xs,g-wxs,o-wxt /etc/ldap.conf
	fi
fi
