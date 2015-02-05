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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 19-Feb-2012 to add checks before running fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22558
#Group Title: GEN008040
#Rule ID: SV-26945r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008040
#Rule Title: If the system is using LDAP for authentication or account information, the system must check that the LDAP server's certificate has not been revoked.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. Communication between an LDAP server and a host using LDAP requires authentication.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check if the system is using NSS LDAP.
# grep -v '^#' /etc/nsswitch.conf | grep ldap
#If no lines are returned, this vulnerability is not applicable.
#
#Check that the NSS LDAP client is configured to check certificates against a certificate revocation list.
# grep -i '^tls_crlcheck' /etc/ldap.conf
#If the setting does not exist, or the value is not "all", this is a finding.
#
#Fix Text: Edit /etc/ldap.conf and add or set the "tls_crlcheck" setting to "all".    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008040

#Start-Lockdown

# The nsswitch check above doesn't include if ldap is configure for 
# authentication. Lets check for that and for pam_ldap as well. 

RUNFIX=0
grep -v '^#' /etc/nsswitch.conf | grep ldap > /dev/null
if [ $? -eq 0 ]; then
	RUNFIX=1
fi

grep -v '^#' /etc/pam.d/* | grep pam_ldap > /dev/null
if [ $? -eq 0 ]; then
	RUNFIX=1
fi

if [ $RUNFIX -eq 1 ]; then
	if [ -e /etc/ldap.conf ]; then
		echo '==================================================='
		echo ' Patching GEN008040: Configure tls_crlceck in LDAP'
		echo '==================================================='
		grep '^tls_crlcheck ' /etc/ldap.conf > /dev/null
		if [ $? -eq 0 ]; then
			grep '^tls_crlcheck all$' /etc/ldap.conf > /dev/null
			if [ $? -ne 0 ]; then
				sed -i -e 's/^tls_crlcheck .*/tls_crlcheck all/g' /etc/ldap.conf
			fi
		else
			echo "#Entry added by STIG check $PDI" >> /etc/ldap.conf
			echo "tls_crlcheck all" >> /etc/ldap.conf
		fi
	fi
fi
