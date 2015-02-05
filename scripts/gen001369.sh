#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#Group ID (Vulid): V-22326
#Group Title: GEN001369
#Rule ID: SV-26413r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001369
#Rule Title: The /etc/hosts file must not have an extended ACL.
#
#Vulnerability Discussion: The /etc/hosts file (or equivalent) configures local host name to IP address mappings that typically take precedence over DNS resolution. If this file is maliciously modified, it could cause the failure or compromise of security functions requiring name resolution, which may include time synchronization, centralized authentication, and remote system logging.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/hosts has no extended ACL.
# ls -l /etc/hosts
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/hosts   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001369

#Start-Lockdown
if [ -a "/etc/hosts" ]; then
	echo '==================================================='
	echo ' Patching GEN001369: Remove ACLs from /etc/hosts'
	echo '==================================================='

	ACLOUT=`getfacl --skip-base /etc/hosts 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/hosts
	fi
fi

