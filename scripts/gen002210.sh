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
# on 16-jan-2012 to speed up and simplify the script.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22365
#Group Title: GEN002210
#Rule ID: SV-26489r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002210
#Rule Title: All shell files must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: If shell files are group-owned by users other than root or a system group, they could be modified by intruders or malicious users to perform unauthorized actions.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#If /etc/shells exists, check the group ownership of each shell referenced.
#
#Procedure:
# cat /etc/shells | xargs -n1 ls -l
#
#Otherwise, check any shells found on the system.
#Procedure:
# find / -name "*sh" | xargs -n1 ls -l
#
#If a shell is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the shell to root, bin, sys, or system.
#
#Procedure:
# chgrp root <shell>  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002210: All Shell Files must be owned'
echo '                     by root'
echo '==================================================='

#Global Variables#
PDI=GEN002210

#Start-Lockdown
find /bin/bash /sbin/nologin /bin/tcsh /bin/csh /bin/ksh /bin/sync /sbin/shutdown /sbin/halt ! -group root ! -group bin ! -group sys -exec chgrp root {} \; 2> /dev/null
