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
#  - Updated by Shannon Mitchell shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to check the permissions before running the chmod command.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22337
#Group Title: GEN001393
#Rule ID: SV-26433r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001393
#Rule Title: The /etc/group file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: The /etc/group file is critical to system security and must be protected from unauthorized modification. The group file contains a list of system groups and associated information.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the /etc/group file.
# ls -l /etc/group
#If the file mode is more permissive than 0644, this is a finding.
#
#Fix Text: Change the mode of the /etc/group file to 0644 or less permissive.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001393

#Start-Lockdown
if [ -a "/etc/group" ]; then
	echo '==================================================='
	echo ' Patching GEN001393: /etc/group Permissions'
	echo '==================================================='

	# Pull the actual permissions
	FILEPERMS=`stat -L --format='%04a' /etc/group`

	# Break the actual file octal permissions up per entity
	FILESPECIAL=${FILEPERMS:0:1}
	FILEOWNER=${FILEPERMS:1:1}
    	FILEGROUP=${FILEPERMS:2:1}
	FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
	if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]; then
		chmod u-xs,g-wxs,o-wxt /etc/group
    	fi
fi
