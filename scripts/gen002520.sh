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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 23-jan-2012 to use find to add a check before changing ownership.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-807
#Group Title: Public directories ownership
#Rule ID: SV-807r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002520
#Rule Title: All public directories must be owned by root or an application account.
#
#Vulnerability Discussion: If a public directory has the sticky bit set and is not owned by a privileged UID, unauthorized users may be able to modify files created by others.
#
#The only authorized public directories are those temporary directories supplied with the system or those designed to be temporary file repositories. The setting is normally reserved for directories used by the system and by users for temporary file storage (e.g., /tmp) and for directories that require global read/write access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of all public directories.
#
#Procedure:
# find / -type d -perm -1002 -exec ls -ld {} \;
#
#If any public directory is not owned by root or an application user, this is a finding.
#
#Fix Text: Change the owner of public directories to root or an application account.
#
#Procedure:
# chown root /tmp
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002500: Public Directory Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN002520

#Start-Lockdown
find / -type d -perm -1002 ! -user root -exec chown root {} \; 2>/dev/null
