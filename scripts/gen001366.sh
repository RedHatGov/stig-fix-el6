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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 30-dec-2011.  Added a check for existing permissions before making a change.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22323
#Group Title: GEN001366
#Rule ID: SV-26410r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001366
#Rule Title: The /etc/hosts file must be owned by root.
#
#Vulnerability Discussion: The /etc/hosts file (or equivalent) configures local host name to IP address mappings that typically take precedence over DNS resolution. If this file is maliciously modified, it could cause the failure or compromise of security functions requiring name resolution, which may include time synchronization, centralized authentication, and remote system logging.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/hosts file is owned by root.
# ls -l /etc/hosts
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/hosts file to root.
# chown root /etc/hosts   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001366

#Start-Lockdown
if [ -a "/etc/hosts" ]; then
	echo '==================================================='
	echo ' Patching GEN001366: /etc/hosts Ownership'
	echo '==================================================='
	CUROWN=`stat -c %U /etc/hosts`;
	if [ "$CUROWN" != "root" ]; then
		chown root /etc/hosts
	fi
fi

