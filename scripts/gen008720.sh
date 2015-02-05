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
# on 20-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4250
#Group Title: grub.conf permissions
#Rule ID: SV-4250r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008720
#Rule Title: The system's boot loader configuration file(s) must have mode 0600 or less permissive.
#
#Vulnerability Discussion: File permissions greater than 0600 on boot loader configuration files could allow an unauthorized user to view or modify sensitive information pertaining to system boot instructions.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /boot/grub/grub.conf permissions:
#
# ls -lL /boot/grub/grub.conf
#
#If /boot/grub/grub.conf has a mode more permissive than 0600, then this is a finding.
#
#
#Fix Text: Change the mode of the grub.conf file to 0600.
#
# chmod 0600 /boot/grub/grub.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008720

#Start-Lockdown
if [ -a "/boot/grub/grub.conf" ]; then
echo '==================================================='
echo ' Patching GEN008720: grub.conf Permissions'
echo '==================================================='

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /boot/grub/grub.conf`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7177)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]; then
        chmod u-xs,g-rwxs,o-rwxt /boot/grub/grub.conf
    fi
fi

