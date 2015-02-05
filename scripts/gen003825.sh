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
# on 04-Feb-2012 to check if the packages is installed before removing it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22431
#Group Title: GEN003825
#Rule ID: SV-26667r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003825
#Rule Title: The rshd service must not be installed.
#
#Vulnerability Discussion: The rshd process provides a typically unencrypted, host-authenticated remote access service. SSH should be used in place of this service.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#Check if the rsh-server package has been installed.
#
#Procedure:
# rpm -qa | grep rsh-server
#
#If a package is found, this is a finding.
#
#Fix Text: Remove the rsh-server package.
#
#Procedure:
# rpm -e rsh-server  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003825: Remove RSH Server Package'
echo '==================================================='

#Global Variables#
PDI=GEN003825

#Start-Lockdown
rpm -q rsh-server > /dev/null
if [ $? -eq 0 ]; then
	rpm -e --nodeps remove rsh-server
fi
