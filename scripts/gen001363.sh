#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to include a group ownership check before running.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22320
#Group Title: GEN001363
#Rule ID: SV-26396r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001363
#Rule Title: The /etc/resolv.conf file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: The resolv.conf (or equivalent) file configures the system's DNS resolver. DNS is used to resolve host names to IP addresses. If DNS configuration is modified maliciously, host name resolution may fail or return incorrect information. DNS may be used by a variety of system security functions such as time synchronization, centralized authentication, and remote system logging.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the resolv.conf file.
#
#Procedure:
# ls -lL /etc/resolv.conf
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/resolv.conf file to root, bin, sys, or system.
#
#Procedure:
# chgrp root /etc/resolv.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001363

#Start-Lockdown
if [ -a "/etc/resolv.conf" ]; then
echo '==================================================='
echo ' Patching GEN001363: /etc/resolv.conf Group'
echo '                     Ownership'
echo '==================================================='
    CURGOWN=`stat -c %G /etc/resolv.conf`;
    if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]; then
        chgrp root /etc/resolv.conf
    fi
fi
