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
# on 30-dec-2011 to include a group ownership check before running. Fixed
# a bug that had the wrong check for /etc/securetty instead of /etc/shadow.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22339
#Group Title: GEN001410
#Rule ID: SV-26437r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001410
#Rule Title: The /etc/shadow (or equivalent) file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: The /etc/shadow file contains the list of local system accounts. It is vital to system security and must be protected from unauthorized modification. The file also contains password hashes which must not be accessible to users other than root.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the /etc/shadow file.
#
#Procedure:
# ls -lL /etc/shadow
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/shadow file.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001410

#Start-Lockdown
if [ -a "/etc/shadow" ]; then
	echo '==================================================='
	echo ' Patching GEN001410: /etc/shadow Group Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/shadow`;
	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]; then
		chgrp root /etc/shadow
	fi
fi
