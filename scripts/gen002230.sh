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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22366
#Group Title: GEN002230
#Rule ID: SV-26490r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002230
#Rule Title: All shell files must not have extended ACLs.
#
#Vulnerability Discussion: Shells with world/group write permissions give the ability to maliciously modify the shell to obtain unauthorized access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#If /etc/shells exists, check the permissions of each shell referenced.
# cat /etc/shells | xargs -n1 ls -lL
#
#Otherwise, check any shells found on the system.
# find / -name "*sh" | xargs -n1 ls -lL
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [shell] 
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002230: Remove ACLs from Shell Files'
echo '==================================================='

#Global Variables#
PDI=GEN002230

SHELLS=$(cat /etc/shells)

#Start-Lockdown
for FILE in $SHELLS; do
	if [ -x $FILE ]; then
		setfacl --remove-all $FILE
	fi
done

