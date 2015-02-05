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
# on 18-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22560
#Group Title: GEN008080
#Rule ID: SV-26947r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008080
#Rule Title: If the system is using LDAP for authentication or account information, the /etc/ldap.conf (or equivalent) file must be owned by root.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the file.
# ls -lL /etc/ldap.conf
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the file.
# chown root /etc/ldap.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008080

#Start-Lockdown
if [ -a "/etc/ldap.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN008080: ldap.conf Ownership'
	echo '==================================================='
	CUROWN=`stat -c %U /etc/ldap.conf`;
	if [ "$CUROWN" != "root" ]; then
		chown root /etc/ldap.conf
	fi
fi
