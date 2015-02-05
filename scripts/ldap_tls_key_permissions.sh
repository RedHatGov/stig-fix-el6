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
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS key file must have mode 0600 or less permissive.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Note: Depending on the particular implementation, group and other read permission may be necessary for unprivileged users to successfully resolve account information using LDAP. This will still be a finding, as these permissions provide users with access to system authenticators.
#
#Responsibility: System Administrator
#
#Check Content: 
#Determine the key file.
# grep -i '^tls_key' /etc/ldap.conf
#Check the permissions.
# ls -lL <keypath>
#If the mode of the file is more permissive than 0600, this is a finding.
#
#Fix Text: Change the mode of the file.

#Global Variables#
PDI=ldap_tls_key_permissions

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Remediation: LDAP TLS Key Permissions'
	echo '==================================================='
	TLSKEY=$(  grep -i '^tls_key' /etc/ldap.conf | awk '{print $2}' )
	for line in $TLSKEY; do
		if [ -a $TLSKEY ]; then
			# Pull the actual permissions
			FILEPERMS=`stat -L --format='%04a' $TLSKEY`

			# Break the actual file octal permissions up per entity
			FILESPECIAL=${FILEPERMS:0:1}
			FILEOWNER=${FILEPERMS:1:1}
			FILEGROUP=${FILEPERMS:2:1}
			FILEOTHER=${FILEPERMS:3:1}

			# Run check by 'and'ing the unwanted mask(7377)
			if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]; then
				chmod u-x,g-rwxs,o-rwxt $TLSKEY
			fi
		fi
	done
fi
