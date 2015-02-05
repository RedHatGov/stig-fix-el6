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
#   - Updated by shannon.mitchell@fusiontechnology-llc.com on 04-feb-2012
# to check permissions before running chmod and to allow for "less permissive" 
# permissions.  


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22425
#Group Title: GEN003750
#Rule ID: SV-26655r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003750
#Rule Title: The xinetd.d directory must have mode 0755 or less permissive.
#
#Vulnerability Discussion: The Internet service daemon configuration files must be protected as malicious modification could cause denial of service or increase the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the xinetd configuration directories.
# ls -dlL /etc/xinetd.d
#If the mode of the directory is more permissive than 0755, this is a finding.
#
#Fix Text: Change the mode of the directory.
# chmod 0755 /etc/xinetd.d
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003750

#Start-Lockdown

if [ -d "/etc/xinetd.d" ]; then
	echo '==================================================='
	echo ' Patching GEN003750: xinetd Files Permissions'
	echo '==================================================='

	# Pull the actual permissions
	FILEPERMS=`stat -L --format='%04a' /etc/xinetd.d`

	# Break the actual file octal permissions up per entity
	FILESPECIAL=${FILEPERMS:0:1}
	FILEOWNER=${FILEPERMS:1:1}
	FILEGROUP=${FILEPERMS:2:1}
	FILEOTHER=${FILEPERMS:3:1}

	# Run check by 'and'ing the unwanted mask(7022)
	if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]; then
		chmod u-s,g-ws,o-wt /etc/xinetd.d
	fi
fi
