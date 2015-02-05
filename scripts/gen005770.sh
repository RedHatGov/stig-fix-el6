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
# on 12-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22493
#Group Title: GEN005770
#Rule ID: SV-26814r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005770
#Rule Title: The NFS exports configuration file must not have an extended ACL.
#
#Vulnerability Discussion: File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files. Excessive permissions on the NFS export configuration file could allow unauthorized modification of the file, which could result in denial of service to authorized NFS exports and the creation of additional unauthorized exports.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the NFS export configuration file.
# ls -lL /etc/exports
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/exports   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005770: Remove ACLs from /etc/exports'
echo '==================================================='

#Global Variables#
PDI=GEN005770

#Start-Lockdown
if [ -a "/etc/exports" ]; then
	ACLOUT=`getfacl --skip-base /etc/exports 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/exports
	fi
fi

