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
#Group ID (Vulid): V-4687
#Group Title: Remote Login or Shell Is Enabled
#Rule ID: SV-27436r1_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN003820
#Rule Title: The rsh daemon must not be running.
#
#Vulnerability Discussion: The rshd process provides a typically unencrypted, host-authenticated remote access service. SSH should be used in place of this service.
#
#
#Responsibility: System Administrator
#IAControls: EBRU-1
#
#Check Content: 
#Check to see if rshd is configured to run on startup.
#
#Procedure:
# grep disable /etc/xinetd.d/rsh
#
#If /etc/xinetd.d/rsh exists and rsh is found to be enabled, this is a finding.
#
#Fix Text: Edit /etc/xinetd.d/rsh and set "disable=yes".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003820

#Start-Lockdown

#Check if rsh installed
if [ -e /etc/xinetd.d/rsh ]; then
echo '==================================================='
echo ' Patching GEN003820: Disable rshd Daemon'
echo '==================================================='
    sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' /etc/xinetd.d/rsh 
fi
