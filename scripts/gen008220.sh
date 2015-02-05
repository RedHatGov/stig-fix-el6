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
#Group ID (Vulid): V-22567
#Group Title: GEN008220
#Rule ID: SV-26954r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008220
#Rule Title: For systems using NSS LDAP, the TLS certificate file must be owned by root.
#
#Vulnerability Discussion: The NSS LDAP service provides user mappings which are a vital component of system security. Its configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate file.
# grep -i '^tls_cert' /etc/ldap.conf
#Check the ownership.
# ls -lL <certpath>
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the ownership of the file.
# chown root <certpath>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008220

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008220: LDAP TLS Certificate Ownership'
	echo '==================================================='
	TLSCERTS=$(  grep -i '^tls_cert' /etc/ldap.conf | awk '{print $2}' )
	for line in $TLSCERTS; do
		if [ -a $TLSCERTS ]; then
			CUROWN=`stat -c %U $TLSCERTS`;
			if [ "$CUROWN" != "root" ]; then
				chown -R root $TLSCERTS
			fi
		fi
	done
fi
