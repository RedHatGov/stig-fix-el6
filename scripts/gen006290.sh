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
#Group ID (Vulid): V-22503
#Group Title: GEN006290
#Rule ID: SV-26837r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006290
#Rule Title: The /etc/news/hosts.nntp.nolimit file must not have an extended ACL.
#
#Vulnerability Discussion: File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Excessive permissions on the hosts.nntp.nolimit file may allow unauthorized modification which could lead to denial of service to authorized users or provide access to unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#RHEL uses the InternetNewsDaemon (innd) news server. The file that corresponds to "/etc/news/hosts.nntp.nolimit" is "/etc/news/infeed.conf". Check the permissions for "/etc/news/infeed.conf"::
#
# ls -lL /etc/news/infeed.conf
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/news/infeed.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006290

#Start-Lockdown

if [ -a "/etc/news/innfeed.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN006290: Remove ACLs from innfeed.conf '
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/news/innfeed.conf 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/news/innfeed.conf
	fi
fi
