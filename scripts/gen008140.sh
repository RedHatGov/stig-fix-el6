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
# on 20-Feb-2012 to look at both the tls_certfile, tls_certdir and its contents


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22563
#Group Title: GEN008140
#Rule ID: SV-26950r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008140
#Rule Title: If the system is using LDAP for authentication or
#account information, the TLS certificate authority file and/or
#directory (as appropriate) must be owned by root.
#
#Vulnerability Discussion: LDAP can be used to provide user
#authentication and account information, which are vital to system
#security. The LDAP client configuration must be protected
#from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate authority file and/or directory.
# grep -i '^tls_cacert' /etc/ldap.conf
#For each file or directory returned, check the ownership.
# ls -lLd <certpath>
#If the owner of any file or directory is not root, this is a finding.
##
#Fix Text: Change the ownership of the file or directory.
# chown root <certpath>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008140

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008140: LDAP TLS Certificate Ownership'
	echo '==================================================='

	TLSCERTS=$(  grep -i '^tls_cacert' /etc/ldap.conf | awk '{print $2}' ) 
	for FILEORDIR in $TLSCERTS; do
		find $FILEORDIR ! -user root -exec chown root {} \;
	done
fi
