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
#Group ID (Vulid): V-1023
#Group Title: INN Documentation
#Rule ID: SV-1023r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006240
#Rule Title: The system must not run an Internet Network News (INN) server.
#
#Vulnerability Discussion: Internet Network News (INN) servers access Usenet newsfeeds and store newsgroup articles. INN servers use the Network News Transfer Protocol (NNTP) to transfer information from the Usenet to the server and from the server to authorized remote hosts.
#
#If this function is necessary to support a valid mission requirement, its use must be authorized and approved in the system accreditation package.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# ps -ef | egrep "innd|nntpd"
#
#If an Internet Network News server is running, this is a finding.
#
#
#Fix Text: Disable the INN server.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006240

#Start-Lockdown

if [ -a  '/etc/init.d/innd' ]; then
echo '==================================================='
echo ' Patching GEN006240: Remove News Server'
echo '==================================================='
    rpm -e --nodeps inn
fi

