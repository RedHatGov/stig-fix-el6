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
# on 20-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22586
#Group Title: GEN008760
#Rule ID: SV-26986r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008760
#Rule Title: The system's boot loader configuration files must be owned by root.
#
#Vulnerability Discussion: The system's boot loader configuration files are critical to the integrity of the system and must be protected. Unauthorized modification of these files resulting from improper ownership could compromise the system's boot loader configuration.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the file.
# ls -lLd /boot/grub/grub.conf
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the ownership of the file.
# chown root /boot/grub/grub.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008760

#Start-Lockdown
if [ -a "/boot/grub/grub.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN008760: grub.conf Ownership '
	echo '==================================================='
	CUROWN=`stat -c %U /boot/grub/grub.conf`;
	if [ "$CUROWN" != "root" ]; then
		chown root /boot/grub/grub.conf
	fi
fi
