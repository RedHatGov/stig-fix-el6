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
#Group ID (Vulid): V-22499
#Group Title: GEN006225
#Rule ID: SV-26830r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006225
#Rule Title: Samba must be configured to use an authentication mechanism other than "share."
#
#Vulnerability Discussion: Samba share authentication does not provide for individual user identification and must not be used.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the security mode of the Samba configuration.
# grep -i security /etc/samba/smb.conf
#If the security mode is "share", this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "security" setting to "user" or another valid setting other than "share".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006225
SECURITYSHARE=$( grep -i security /etc/samba/smb.conf | grep -i share | grep -i "=" | wc -l )
#Start-Lockdown
if [ $SECURITYSHARE -ne 0 ]; then
	echo '==================================================='
	echo ' Patching GEN006225: Samba Security Configuration'
	echo '==================================================='

	sed -i 's/[[:blank:]]*security[[:blank:]]*=[[:blank:]]*share/        security = user/g' /etc/samba/smb.conf
fi

