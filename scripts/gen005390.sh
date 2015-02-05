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
# on 05-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22453
#Group Title: GEN005390
#Rule ID: SV-26740r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005390
#Rule Title: The /etc/syslog.conf file must have mode 0640 or less permissive.
#
#Vulnerability Discussion: Unauthorized users must not be allowed to access or modify the /etc/syslog.conf file.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the syslog configuration file.
# ls -lL /etc/syslog.conf
#If the mode of the file is more permissive than 0640, this is a finding.
#
#Fix Text: Change the permissions of the syslog configuration file.
# chmod 0640 /etc/syslog.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005390

#Start-Lockdown

if [ -a "/etc/syslog.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN005390: syslog.conf Permissions'
	echo '==================================================='

	# Pull the actual permissions
	FILEPERMS=`stat -L --format='%04a' /etc/syslog.conf`

	# Break the actual file octal permissions up per entity
	FILESPECIAL=${FILEPERMS:0:1}
	FILEOWNER=${FILEPERMS:1:1}
	FILEGROUP=${FILEPERMS:2:1}
	FILEOTHER=${FILEPERMS:3:1}

	# Run check by 'and'ing the unwanted mask(7137)
	if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]; then
		chmod u-xs,g-wxs,o-rwxt /etc/syslog.conf
	fi
fi
