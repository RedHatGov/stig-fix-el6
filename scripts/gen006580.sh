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
#Group ID (Vulid): V-940
#Group Title: Access Control Program
#Rule ID: SV-28460r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006580
#Rule Title: The system must use an access control program.
#
#Vulnerability Discussion: Access control programs (such as TCP_WRAPPERS) provide the ability to enhance system security posture.
#
#
#Responsibility: System Administrator
#IAControls: EBRU-1
#
#Check Content: 
#Determine if TCP_WRAPPERS is installed.
# rpm -qa | grep tcp_wrappers
#If no package is listed, this is a finding.
#
#Fix Text: Install the tcp_wrappers package.   
#######################DISA INFORMATION###############################
echo '==================================================='
echo ' Checking GEN006580: TCP_WRAPPERS installed'
echo '==================================================='

#Global Variables#
PDI=GEN006580

TCPWAPPA=$( rpm -qa | grep tcp_wrappers | wc -l )
#Start-Lockdown
if [ $TCPWAPPA -eq 0 ]; then
	echo " ERROR: TCP Wrappers not installed."
fi
