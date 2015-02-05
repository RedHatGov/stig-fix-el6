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
# on 13-Feb-2012 to move from dev to prod an create the fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4321
#Group Title: Samba is enabled
#Rule ID: SV-4321r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006060
#Rule Title: The system must not run the Samba service unless needed.
#
#Vulnerability Discussion: Samba is a tool used for the sharing of files and
#printers between Windows and UNIX operating systems. It provides access to
#sensitive files and, therefore, poses a security risk if compromised.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the system for a running Samba server.
#
#Procedure:
# ps -ef |grep smbd
#
#If the Samba server is running, ask the SA if the Samba server is
#operationally required. If it is not, this is a finding.
#
#Fix Text: If there is no functional need for Samba and the daemon is
#running, disable the daemon by killing the process ID as noted from
#the output of ps -ef |grep smbd. The samba package should also be
#removed or not installed if there is no functional requirement.
#
#Procedure:
#rpm -qa |grep samba
#
#this will show whether "samba" or "samba3x" is installed. To remove:
#
#rpm --erase samba
#or
#rpm --erase samba3x
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006060

#Start-Lockdown
rpm -q samba > /dev/null
if [ $? -eq 0 ]; then
echo '==================================================='
echo ' Patching GEN006060: Remove Samba Unless Needed'
echo '==================================================='
	rpm -e --nodeps samba > /dev/null
fi
