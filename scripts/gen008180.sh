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
#Group ID (Vulid): V-22565
#Group Title: GEN008180
#Rule ID: SV-26952r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008180
#Rule Title: If the system is using LDAP for authentication or account information, the TLS certificate authority file and/or directory (as appropriate) must have mode 0644 (0755 for directories) or less permissive.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate authority file and/or directory.
#
#Procedure:
# grep -i '^tls_cacert' /etc/ldap.conf
#For each file or directory returned, check the permissions.
#
#Procedure:
# ls -lLd <certpath>
#
#If the mode of the file is more permissive than 0644 (or 0755 for directories), this is a finding.
#
#Fix Text: Change the mode of the file or directory.
#
#File Procedure:
# chmod 0644 <certpath>
#
#Directory Procedure:
# chmod 0755 <certpath>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008180

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008180: LDAP TLS Certificate Permission'
	echo '==================================================='
	TLSCERTS=$(  grep -i '^tls_cacert' /etc/ldap.conf | awk '{print $2}' )
	for FILEORDIR in $TLSCERTS; do
		find $FILEORDIR -perm /7133 -type f -exec chmod u-xs,g-wxs,o-wxt {} \; 2>/dev/null
		find $FILEORDIR -perm /7022 -type d -exec chmod u-s,g-ws,o-wt {} \; 2>/dev/null
	done
fi
