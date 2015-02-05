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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to include a group ownership check before running.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22328
#Group Title: GEN001372
#Rule ID: SV-26418r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001372
#Rule Title: The /etc/nsswitch.conf file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: The nsswitch.conf file (or equivalent) configures the source of a variety of system security information including account, group, and host lookups. Malicious changes could prevent the system from functioning or compromise system security.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the nsswitch.conf file.
#
#Procedure:
# ls -lL /etc/nsswitch.conf
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/nsswitch.conf file to root, bin, sys, or system.
#
#Procedure:
# chgrp root /etc/nsswitch.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001372

#Start-Lockdown
if [ -a "/etc/nsswitch.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN001372: /etc/nsswitch.conf Group'
	echo '                     Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/nsswitch.conf`;
	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]; then
		chgrp root /etc/nsswitch.conf
	fi
fi


