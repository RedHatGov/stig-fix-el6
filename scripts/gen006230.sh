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
# on 13-Feb-2012 to add the option in the global section.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22500
#Group Title: GEN006230
#Rule ID: SV-26831r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006230
#Rule Title: Samba must be configured to use encrypted passwords.
#
#Vulnerability Discussion: Samba must be configured to protect authenticators.
#If Samba passwords are not encrypted for storage, plain-text user passwords
#may be read by those with access to the Samba password file.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the encryption setting the Samba configuration.
# grep -i 'encrypt passwords' /etc/samba/smb.conf
#If the setting is not present, or not set to 'yes', this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "encrypt passwords" setting to "yes".    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006230

#Start-Lockdown
if [ -e /etc/samba/smb.conf ]; then
	echo '==================================================='
	echo ' Patching GEN006150: Enable Samba Encryption'
	echo '==================================================='

	ENCRYPTPASS=$( grep -i 'encrypt passwords' /etc/samba/smb.conf | wc -l )

	if [ $ENCRYPTPASS -eq 0 ];  then
		# Add to global section
		sed -i 's/\[global\]/\[global\]\n\n\tencrypt passwords = yes/g' /etc/samba/smb.conf
	else
		sed -i 's/[[:blank:]]*encrypt[[:blank:]]passwords[[:blank:]]*=[[:blank:]]*no/        encrypt passwords = yes/g' /etc/samba/smb.conf
	fi
fi
