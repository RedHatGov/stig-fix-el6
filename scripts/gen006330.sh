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
# on 14-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22505
#Group Title: GEN006330
#Rule ID: SV-26848r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006330
#Rule Title: The /etc/news/passwd.nntp file must not have an extended ACL.
#
#Vulnerability Discussion: Extended ACLs may provide excessive permissions on the /etc/news/passwd.nntp file, which may permit unauthorized access or modification to the NNTP configuration.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/news/passwd.nntp
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: RedHat:
#Remove the extended ACL from the file.
# setfacl --remove-all /etc/news/passwd.nntp   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006330

#Start-Lockdown
if [ -a "/etc/news/passwd.nntp" ]; then
	echo '==================================================='
	echo ' Patching GEN006330: Remove ACLs from passwd.nntp'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/news/passwd.nntp 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/news/passwd.nntp
	fi
fi
