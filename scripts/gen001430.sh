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
#Group ID (Vulid): V-22340
#Group Title: GEN001430
#Rule ID: SV-26438r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001430
#Rule Title: The /etc/shadow (or equivalent) file must not have an extended ACL.
#
#Vulnerability Discussion: The /etc/shadow file contains the list of local system accounts. It is vital to system security and must be protected from unauthorized modification. The file also contains password hashes which must not be accessible to users other than root.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/shadow has no extended ACL.
# ls -l /etc/shadow
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/shadow  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001430

#Start-Lockdown
if [ -a "/etc/shadow" ]; then
	echo '==================================================='
	echo ' Patching GEN001430: Remove ACLS from /etc/shadow'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/shadow 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/shadow
	fi
fi
