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
#Group ID (Vulid): V-22497
#Group Title: GEN006150
#Rule ID: SV-26822r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006150
#Rule Title: The /etc/samba/smb.conf file must not have an extended ACL.
#
#Vulnerability Discussion: Excessive permissions could endanger the security of the Samba configuration file and, ultimately, the system and network.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the Samba configuration file.
# ls -lL /etc/samba/smb.conf
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/samba/smb.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006150

#Start-Lockdown
if [ -a "/etc/samba/smb.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN006150: Remove ACLs from smb.conf'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/samba/smb.conf 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/samba/smb.conf
	fi
fi
