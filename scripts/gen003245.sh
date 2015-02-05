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
# on 31-jan-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22390
#Group Title: GEN003245
#Rule ID: SV-26548r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003245
#Rule Title: The at.allow file must not have an extended ACL.
#
#Vulnerability Discussion: File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Unauthorized modification of the at.allow file could result in denial of service to authorized "at" users and the granting of the ability to run "at" jobs to unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/at.allow
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/at.allow    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003245

#Start-Lockdown
if [ -a "/etc/at.allow" ]; then
	echo '==================================================='
	echo ' Patching GEN003245: Remove ACLs from /etc/at.allow'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/at.allow 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/at.allow
	fi
fi
