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
# on 20-Feb-2012 to point to the correct config entry.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22568
#Group Title: GEN008240
#Rule ID: SV-26955r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008240
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS certificate file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate file.
#Procedure:
# grep -i '^tls_cert' /etc/ldap.conf
#
#Check the group-ownership.
#Procedure:
# ls -lL <certpath>
#
#If the group-owner of the file is not root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-ownership of the file.
#
#Procedure:
# chgrp root <certpath>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008240

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008240: LDAP TLS Certificate Group'
	echo '                     Ownership'
	echo '==================================================='
	TLSCERTS=$(  grep -i '^tls_cert' /etc/ldap.conf | awk '{print $2}' ) 
	for line in $TLSCERTS; do
		if [ -a $TLSCERTS ]; then
			CURGOWN=`stat -c %G $TLSCERTS`;
			if [ "$CURGOWN" != "root" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "system" ]; then
				chgrp root $TLSCERTS
			fi
		fi
	done
fi
