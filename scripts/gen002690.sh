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
# on 24-jan-2012 to remove the echo and uncomment out the actual chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22702
#Group Title: GEN002690
#Rule ID: SV-27281r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002690
#Rule Title: System audit logs must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: Sensitive system and user information could provide a malicious user with enough information to penetrate further into the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1, ECTP-1
#
#Check Content: 
#Check the group ownership of the audit logs.
#
#
#Procedure:
# grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %G:%n
#
#If any audit log file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-ownership of the audit log file(s).
#
#Procedure:
# chgrp root <audit log file> 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002690

LOGFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %U:%n | cut -d ":" -f 2 )
BADELOGFILES=$( for line in $LOGFILES; do find $line ! -group root ! -group sys ! -group bin ; done )

#Start-Lockdown
echo '==================================================='
echo ' Patching GEN005590: Audit Log File Ownership'
echo '==================================================='
for file in $BADELOGFILES; do
	chgrp root $file
done
