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
# on 02-feb-2012 to check permissions before running chmod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22392
#Group Title: GEN003252
#Rule ID: SV-26555r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003252
#Rule Title: The at.deny file must have mode 0600 or less permissive.
#
#Vulnerability Discussion: The "at" daemon control files restrict access to scheduled job manipulation and must be protected. Unauthorized modification of the at.deny file could result in denial of service to authorized "at" users or provide unauthorized users with the ability to run "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/at.deny
#If the file has a mode more permissive than 0600, this is a finding.
#
#Fix Text: Change the mode of the file.
# chmod 0600 /etc/at.deny  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003252

#Start-Lockdown
if [ -e "/etc/at.deny" ]; then
	echo '==================================================='
	echo ' Patching GEN003252: /etc/at.deny Permissions'
	echo '==================================================='
	find /etc/at.deny -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;
fi
