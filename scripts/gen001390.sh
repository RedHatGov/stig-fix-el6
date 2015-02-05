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
#Group ID (Vulid): V-22334
#Group Title: GEN001390
#Rule ID: SV-26427r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001390
#Rule Title: The /etc/passwd file must not have an extended ACL.
#
#Vulnerability Discussion: File system ACLs can provide access to files beyond what is allowed by the mode numbers of the files. The /etc/passwd file contains the list of local system accounts. It is vital to system security and must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/passwd has no extended ACL.
# ls -l /etc/passwd
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/passwd 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001390

#Start-Lockdown
if [ -a "/etc/passwd" ]; then
	echo '==================================================='
	echo ' Patching GEN001390: Remove ACLS from /etc/passwd'
	echo '==================================================='

	ACLOUT=`getfacl --skip-base /etc/passwd 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/passwd
	fi
fi
