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
# on 30-jan-2012 to check for ACL's before removing them.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22386
#Group Title: GEN003090
#Rule ID: SV-26532r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003090
#Rule Title: Crontab files must not have extended ACLs.
#
#Vulnerability Discussion: To protect the integrity of scheduled system jobs and to prevent malicious modification to these jobs, crontab files must be secured. ACLs on crontab files may provide unauthorized access to the files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the crontab files.
#Procedure:
#
# ls -lL /var/spool/cron
#
# ls -lL /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
#or
# ls -lL /etc/cron*|grep -v deny
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [crontab file]   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003090: Remove ACLs from Cron Files'
echo '==================================================='

#Global Variables#
PDI=GEN003090

#Start-Lockdown
for CRONFILE in `find /var/spool/cron /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly -type f 2>/dev/null`; do
	ACLOUT=`getfacl --skip-base $CRONFILE 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all $CRONFILE
  	fi
done
