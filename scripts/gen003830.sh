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
#Group ID (Vulid): V-22432
#Group Title: GEN003830
#Rule ID: SV-26671r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003830
#Rule Title: The rlogind service must not be running.
#
#Vulnerability Discussion: The rlogind process provides a typically unencrypted, host-authenticated remote access service. SSH should be used in place of this service.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check the rlogind configuration.
# cat /etc/xinetd.d/rlogin
#If the file exists and does not contain "disable = yes" this is a finding.
#
#Fix Text: Remove or disable the rlogin configuration and restart xinetd.
# rm /etc/xinetd.d/rlogin ; service xinetd restart    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003830

#Start-Lockdown
RLOGIN='/etc/xinetd.d/rlogin'
if [ -a $RLOGIN ]; then
	echo '==================================================='
	echo ' Patching GEN003830: Disable rlogin Service'
	echo '==================================================='
	rm -f /etc/xinetd.d/rlogin
	service xinetd restart
fi

