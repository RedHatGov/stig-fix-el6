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
# on 02-feb-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22393
#Group Title: GEN003255
#Rule ID: SV-26558r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003255
#Rule Title: The at.deny file must not have an extended ACL.
#
#Vulnerability Discussion: The "at" daemon control files restrict access to scheduled job manipulation and must be protected. Unauthorized modification of the at.deny file could result in denial of service to authorized "at" users or provide unauthorized users with the ability to run "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/at.deny
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/at.deny    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003255

#Start-Lockdown
if [ -a "/etc/at.deny" ]; then
	echo '==================================================='
	echo ' Patching GEN003255: Remove ACLs from /etc/at.deny'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/at.deny 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/at.deny
	fi
fi
