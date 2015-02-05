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
#Group ID (Vulid): V-22330
#Group Title: GEN001374
#Rule ID: SV-26420r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001374
#Rule Title: The /etc/nsswitch.conf file must not have an extended ACL.
#
#Vulnerability Discussion: The nsswitch.conf file (or equivalent) configures the source of a variety of system security information including account, group, and host lookups. Malicious changes could prevent the system from functioning or compromise system security.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/nsswitch.conf has no extended ACL.
# ls -l /etc/nsswitch.conf
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001374

#Start-Lockdown
if [ -a "/etc/nsswitch.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN001374: Remove ACLS from'
	echo '                     /etc/nsswitch.conf'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/nsswitch.conf 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/nsswitch.conf
	fi
fi
