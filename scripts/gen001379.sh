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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to include a group ownership check before running.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22333
#Group Title: GEN001379
#Rule ID: SV-26426r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001379
#Rule Title: The /etc/passwd file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: The /etc/passwd file contains the list of local system accounts. It is vital to system security and must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the passwd file.
#
#Procedure:
# ls -lL /etc/passwd
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/passwd file to root, bin, sys, or system. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001379

#Start-Lockdown
if [ -a "/etc/passwd" ]; then
	echo '==================================================='
	echo ' Patching GEN001379: /etc/passwd Group Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/passwd`;
	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]; then
		chgrp root /etc/passwd
	fi
fi
