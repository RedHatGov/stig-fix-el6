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
# on 30-dec-2011 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22338
#Group Title: GEN001394
#Rule ID: SV-26434r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001394
#Rule Title: The /etc/group file must not have an extended ACL.
#
#Vulnerability Discussion: The /etc/group file is critical to system security and must be protected from unauthorized modification. The group file contains a list of system groups and associated information.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/group has no extended ACL.
# ls -l /etc/group
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001394

#Start-Lockdown
if [ -a "/etc/group" ]; then
	echo '==================================================='
	echo ' Patching GEN001394: Remove ACLS from /etc/group'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/group 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/group
	fi
fi
