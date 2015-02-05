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
# on 04-feb-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22426
#Group Title: GEN003755
#Rule ID: SV-26656r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003755
#Rule Title: The xinetd.d directory must not have an extended ACL.
#
#Vulnerability Discussion: The Internet service daemon configuration files must be protected as malicious modification could cause denial of service or increase the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the xinetd configuration files and directories.
# ls -alL /etc/xinetd.conf /etc/xinetd.d
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/xinetd.d   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003755

#Start-Lockdown
if [ -a "/etc/xinetd.d" ]; then
	echo '==================================================='
	echo ' Patching GEN003755: Remove ACLs from xinetd Files'
	echo '==================================================='

	ACLOUT=`getfacl --skip-base /etc/xinetd.d 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/xinetd.d
	fi
fi
