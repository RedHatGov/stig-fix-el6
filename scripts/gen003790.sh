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
# on 04-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22428
#Group Title: GEN003790
#Rule ID: SV-26658r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003790
#Rule Title: The services file must not have an extended ACL.
#
#Vulnerability Discussion: The services file is critical to the proper operation of network services and must be protected from unauthorized modification. If the services file has an extended ACL, it may be possible for unauthorized users to modify the file. Unauthorized modification could result in the failure of network services.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /etc/services file.
# ls -lL /etc/services
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/services   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003790

#Start-Lockdown
if [ -a "/etc/services" ]; then
	echo '==================================================='
	echo ' Patching GEN003790: Remove ACLs from /etc/services'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/services 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/services
	fi
fi
