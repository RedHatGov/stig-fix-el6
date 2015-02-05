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
# on 13-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22502
#Group Title: GEN006270
#Rule ID: SV-26833r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006270
#Rule Title: The /etc/news/hosts.nntp file must not have an extended ACL.
#
#Vulnerability Discussion: File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Excessive permissions on the hosts.nntp file may allow unauthorized modification which could lead to denial of service to authorized users or provide access to unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/news/hosts.nntp
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/news/hosts.nntp   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006270

#Start-Lockdown
if [ -a "/etc/news/incoming.conf" ];then
	echo '==================================================='
	echo ' Patching GEN006270: Remove ACLs from incoming.conf'
	echo '==================================================='

	ACLOUT=`getfacl --skip-base /etc/news/incoming.conf 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/news/incoming.conf
	fi
fi
