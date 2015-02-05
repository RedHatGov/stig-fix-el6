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
# on 09-jan-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22318
#Group Title: GEN001361
#Rule ID: SV-26383r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001361
#Rule Title: NIS/NIS+/yp command files must not have extended ACLs.
#
#Vulnerability Discussion: NIS/NIS+/yp files are part of the system's identification and authentication processes and are, therefore, critical to system security. ACLs on these files could result in unauthorized modification, which could compromise these processes and the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that NIS/NIS+/yp files have no extended ACLs.
# ls -lL /var/yp/*
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /var/yp/*   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001361

#Start-Lockdown
if [ -d /var/yp ]; then
	echo '==================================================='
	echo ' Patching GEN001361: Remove ACLs from NIS'
	echo '==================================================='
	for FILE in `find /var/yp -type f`; do
	  	ACLOUT=`getfacl --skip-base $FILE 2>/dev/null`;
	  	if [ "$ACLOUT" != "" ]; then
	    		setfacl --remove-all $FILE
	  	fi
	done
fi
