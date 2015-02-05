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
# on 02-feb-2012 to check enabled status before runing chkconfig.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22404
#Group Title: GEN003510
#Rule ID: SV-26604r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003510
#Rule Title: Kernel core dumps must be disabled unless needed.
#
#Vulnerability Discussion: Kernel core dumps may contain the full contents of system memory at the time of the crash. Kernel core dumps may consume a considerable amount of disk space and may result in denial of service by exhausting the available space on the target file system. The kernel core dump process may increase the amount of time a system is unavailable due to a crash. Kernel core dumps can be useful for kernel debugging.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the kdump service is not running.
# service kdump status
#If "Kdump is operational" is returned, this is a finding.
#
#
#Fix Text: Disable kdump.
# service kdump stop
# chkconfig kdump off  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003510: Disable kdump Service'
echo '==================================================='

#Global Variables#
PDI=GEN003510

#Start-Lockdown
chkconfig --list | grep kdump | egrep '[2-5]:on' &>/dev/null
if [ $? -eq 0 ]; then
	service kdump stop
	chkconfig --level 2345 kdump off
fi
