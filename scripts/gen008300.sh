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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22571
#Group Title: GEN008300
#Rule ID: SV-26958r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008300
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS key file must be owned by root.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the key file.
# grep -i '^tls_key' /etc/ldap.conf
#Check the ownership.
# ls -lL <keypath>
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the ownership of the file.
# chown root <keypath>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008300
#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008300: LDAP TLS Key Ownership'
	echo '==================================================='
	TLSKEY=$(  grep -i '^tls_key' /etc/ldap.conf | awk '{print $2}' )
	for line in $TLSKEY; do
		if [ -a $TLSKEY ]; then
			CUROWN=`stat -c %U $TLSKEY`;
			if [ "$CUROWN" != "root" ]; then
				chown root $TLSKEY
			fi
		fi
	done
fi
