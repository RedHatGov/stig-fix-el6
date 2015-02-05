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
# on 05-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22439
#Group Title: GEN004390
#Rule ID: SV-26685r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004390
#Rule Title: The sendmail alias file must not have an extended ACL.
#
#Vulnerability Discussion: Excessive permissions on the alias files may permit unauthorized modification. If an alias file is modified by an unauthorized user, they may modify the file to run malicious code or redirect e-mail.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /etc/mail/aliases file.
# ls -lL /etc/aliases /etc/aliases.db
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Check the permissions of the alias files.
#
#Procedure:
# setfacl --remove-all /etc/aliases /etc/aliases.db
#If the permissions include a '+', the file has an extended ACL, this is a finding.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004390

#Start-Lockdown
if [[ -e /etc/aliases || -e /etc/aliases.db ]]; then
	echo '==================================================='
	echo ' Patching GEN004390: Remove ACLs from /etc/aliases'
	echo '==================================================='
fi

if [ -a "/etc/aliases" ]; then
	ACLOUT=`getfacl --skip-base /etc/aliases 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/aliases
	fi
fi

if [ -a "/etc/aliases.db" ]; then
	ACLOUT=`getfacl --skip-base /etc/aliases.db 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/aliases.db
	fi
fi

