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
# - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-feb-2012 to cut back on the output from sysctl -p.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11999
#Group Title: Disable Executable Stack
#Rule ID: SV-27414r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003540
#Rule Title: The system must implement non-executable program stacks.
#
#Vulnerability Discussion: A common type of exploit is the stack buffer overflow. An application receives, from an attacker, more data than it is prepared for and stores this information on its stack, writing beyond the space reserved for it. This can be designed to cause execution of the data written on the stack. One mechanism to mitigate this vulnerability is for the system to not allow the execution of instructions in sections of memory identified as part of the stack.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the operating system version is prior to Red Hat Enterprise 4, this is a finding. If this is not the case verify that "exec_shield" and "randomize_va_space" have not been changed from the default "1" settings.
#
#Procedure:
#sysctl kernel.exec-shield
#If the return value is not:
#kernel.exec-shield = 1
#this is a finding.
#
#
#sysctl kernel.randomize_va_space
#If the return value is not:
#kernel.randomize_va_space = 1
#this is a finding.
#
#
#
#Fix Text: Upgrade the operating system to Red Hat Enterprise 4 or later.
#Fix Text: Examine /etc/sysctl.conf for "kernel.exec-shield" and "kernel.randomize_va_space" entries and if found remove them. The system default of "1" enables these modules.
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003540: Disable Executable Stack'
echo '==================================================='

# Handled by provided sysctl.conf - extra test

#Global Variables#
PDI=GEN003540
KERNEXEC=$( sysctl kernel.exec-shield | awk '{print $3}' )
KERNRAND=$( sysctl kernel.randomize_va_space | awk '{print $3}' )

#Start-Lockdown

if [ $KERNEXEC -ne 1 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "kernel.exec-shield = 1" >> /etc/sysctl.conf
    sysctl -p &> /dev/null
fi

if [ $KERNRAND -ne 2 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
    sysctl -p &> /dev/null
fi
