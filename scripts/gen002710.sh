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
#Group ID (Vulid): V-22369
#Group Title: GEN002710
#Rule ID: SV-26500r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002710
#Rule Title: All system audit files must not have extended ACLs.
#
#Vulnerability Discussion: If a user can write to the audit logs, then audit trails can be modified or destroyed and system intrusion may not be detected.
#
#Responsibility: System Administrator
#IAControls: ECTP-1
#
#Check Content: 
#Check the system audit log files for extended ACLs.
#
#Procedure:
# grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs ls -l
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <audit file>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002710: Remove ACLs from Log Files'
echo '==================================================='

#Global Variables#
PDI=GEN002710

LOGACLFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs ls -l | awk '{print $9}' )
BADLOGACLFILES=$( for line in $LOGACLFILES ; do getfacl --absolute-names --skip-base $line| grep "# file:" | cut -d ":" -f 2 ; done )

#Start-Lockdown
for FILE in $BADLOGACLFILES; do
    setfacl --remove-all $FILE
done



