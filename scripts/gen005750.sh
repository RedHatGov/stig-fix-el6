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
# on 12-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22492
#Group Title: GEN005750
#Rule ID: SV-26812r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005750
#Rule Title: The NFS export configuration file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: Failure to give group-ownership of the NFS export configuration file to root or a system group provides the designated group-owner and possible unauthorized users with the potential to change system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the NFS export configuration file.
#
#Procedure:
# ls -lL /etc/exports
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group ownership of the NFS export configuration file.
#
#Procedure:
# chgrp root /etc/exports    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005750: /etc/exports Group Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN005750

#Start-Lockdown
if [ -a "/etc/exports" ]; then
	CURGROUP=`stat -c %G /etc/exports`;
	if [  "$CURGROUP" != "root" ]; then
		chgrp root /etc/exports
	fi
fi

