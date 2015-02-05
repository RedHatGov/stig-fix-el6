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
#Group ID (Vulid): V-22332
#Group Title: GEN001378
#Rule ID: SV-26425r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001378
#Rule Title: The /etc/passwd file must be owned by root.
#
#Vulnerability Discussion: The /etc/passwd file contains the list of local system accounts. It is vital to system security and must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/passwd file is owned by root.
# ls -l /etc/passwd
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/passwd file to root. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001378

#Start-Lockdown
if [ -a "/etc/passwd" ]; then
	echo '==================================================='
	echo ' Patching GEN001378: /etc/passwd Ownership'
	echo '==================================================='
	CUROWN=`stat -c %U /etc/passwd`;
  	if [ "$CUROWN" != "root" ]; then
      		chown root /etc/passwd
  	fi
fi
