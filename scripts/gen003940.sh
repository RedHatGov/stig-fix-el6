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
# on 04-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-829
#Group Title: The printers.conf file permissions
#Rule ID: SV-829r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003940
#Rule Title: The printers.conf must have mode 0664 or less permissive.
#
#Vulnerability Discussion: Excessive permissions on the printers.conf file may permit unauthorized modification. Unauthorized modifications could disrupt access to local printers from authorized remote hosts or permit unauthorized remote access to local printers.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the print service configuration file
#
#Procedure:
# ls -lL /etc/cups/printers.conf;
#
#If no print service configuration file is found, this is not applicable.
#If the mode of the print service configuration file is more permissive than 0644, this is a finding.
#
#Fix Text: Change the mode of the /etc/cups/printers.conf file to 0664 or less permissive.
#
#Procedure:
# chmod 0664 /etc/cups/printers.conf   
#######################DISA INFORMATION###############################
echo '==================================================='
echo ' Patching GEN003940: Printer Permissions'
echo '==================================================='
#Global Variables#
PDI=GEN003940

#Start-Lockdown
if [ -a "/etc/cups/printers.conf" ]; then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/cups/printers.conf`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7113)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&1)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]; then
        chmod u-xs,g-xs,o-wxt /etc/cups/printers.conf
    fi
fi
