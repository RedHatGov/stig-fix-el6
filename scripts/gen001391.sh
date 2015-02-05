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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 30-dec-2011.  Added a check for existing permissions before making a change.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22335
#Group Title: GEN001391
#Rule ID: SV-26431r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001391
#Rule Title: The /etc/group file must be owned by root.
#
#Vulnerability Discussion: The /etc/group file is critical to system security and must be owned by a privileged user. The group file contains a list of system groups and associated information.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/group file is owned by root.
# ls -l /etc/group
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/group file to root.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001391

#Start-Lockdown
if [ -a "/etc/group" ]; then
	echo '==================================================='
	echo ' Patching GEN001391: /etc/group Ownership'
	echo '==================================================='

	CUROWN=`stat -c %U /etc/group`;
	if [ "$CUROWN" != "root" ]; then
		chown root /etc/group
  	fi
fi
