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
# on 18-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22561
#Group Title: GEN008100
#Rule ID: SV-26948r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008100
#Rule Title: If the system is using LDAP for authentication or account information, the /etc/ldap.conf (or equivalent) file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /etc/ldap.conf
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the file to root, bin, sys, or system.
#
#Procedure:
# chgrp root /etc/ldap.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008100

#Start-Lockdown

if [ -a "/etc/ldap.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN008100: ldap.conf Group Ownership'
	echo '==================================================='
	CURGROUP=`stat -c %G /etc/ldap.conf`;
	if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]; then
		chgrp root /etc/ldap.conf
	fi
fi
