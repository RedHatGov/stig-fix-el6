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
# on 19-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22555
#Group Title: GEN007980
#Rule ID: SV-26941r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007980
#Rule Title: If the system is using LDAP for authentication or 
#account information, the system must use a TLS connection using FIPS 140-2 approved cryptographic algorithms.
#
#Vulnerability Discussion: LDAP can be used to provide user 
#authentication and account information, which are vital to 
#system security. Communication between an LDAP server and a 
#host using LDAP requires protection.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check if the system is using NSS LDAP.
# grep -v '^#' /etc/nsswitch.conf | grep ldap
#If no lines are returned, this vulnerability is not applicable.
#Check if NSS LDAP is using TLS.
# grep '^ssl start_tls' /etc/ldap.conf
#If no lines are returned, this is a finding.
#Check if NSS LDAP TLS is using only FIPS 140-2 approved cryptographic algorithms.
# grep '^tls_ciphers' /etc/ldap.conf
#If the line is not present, or contains ciphers not approved by FIPS 140-2, this is a finding.
#
#Fix Text: Edit /etc/ldap.conf and add a "ssl start_tls" and "tls_ciphers" options with only FIPS 140-2 approved ciphers.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007980

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

if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN007980: Enable LDAP for FIPS 140-2'
	echo '==================================================='
	if [ $RUNFIX -eq 1 ]; then
		if [ -e /etc/ldap.conf ]; then
			grep '^ssl ' /etc/ldap.conf > /dev/null
			if [ $? -eq 0 ]; then
				grep '^ssl start_tls$' /etc/ldap.conf > /dev/null
				if [ $? -ne 0 ]; then
					sed -i -e 's/^ssl .*/ssl start_tls/g' /etc/ldap.conf
				fi
			else
				echo "#Entry added by STIG check $PDI" >> /etc/ldap.conf
				echo "ssl start_tls" >> /etc/ldap.conf
			fi
		fi
	fi
fi
