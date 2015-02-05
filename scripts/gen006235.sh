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
# Edited by Luke "Brisk-OH" Brisk-OH
# luke.brisk@boeing.com or luke.brisk@gmail.com 
# Not a part of the RHEL STIG - 10-27-2014 
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22501
#Group Title: GEN006235
#Rule ID: SV-26832r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006235
#Rule Title: Samba must be configured to not allow guest access to shares.
#
#Vulnerability Discussion: Guest access to shares permits anonymous access and is not permitted.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the encryption setting the Samba configuration.
# grep -i 'guest ok' /etc/samba/smb.conf
#If the setting exists and is set to 'yes', this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "guest ok" setting to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
# PDI=GEN006235

# if [ -e /etc/samba/smb.conf ]; then
	# echo '==================================================='
	# echo ' Patching GEN006235: Disable guest access in Samba'
	# echo '==================================================='

	# GUESTOK=$( grep -i 'guest ok' /etc/samba/smb.conf| grep -i yes | grep -v "^;" | grep -v "^#" | wc -l )
	# GUESTOk2=$( grep -i 'guest ok' /etc/samba/smb.conf| grep -i no | grep -v "^;" | grep -v "^#" | wc -l )
	#Start-Lockdown
	# if [ $GUESTOK -eq 1 ]; then
		# sed -i 's/[[:blank:]]*guest[[:blank:]]ok[[:blank:]]*=[[:blank:]]*yes/        guest ok = no/g' /etc/samba/smb.conf
	# fi

	# if [ $GUESTOk2 -eq 0 ]; then
		# echo "#Added for DISA GEN006235" >> /etc/samba/smb.conf
		# echo "        guest ok = no" >> /etc/samba/smb.conf
	# fi
# fi
