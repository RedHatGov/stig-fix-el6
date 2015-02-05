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
# to add group ownership checks before running chown. 

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22385
#Group Title: GEN003050
#Rule ID: SV-26530r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003050
#Rule Title: Crontab files must be group-owned by root, cron, or the crontab creator's primary group.
#
#Vulnerability Discussion: To protect the integrity of scheduled system jobs and prevent malicious modification to these jobs, crontab files must be secured.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the crontab files.
#Procedure:
#
# ls -lL /var/spool/cron
#
# ls -lL /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
#or
# ls -lL /etc/cron*|grep -v deny
#
#If the group-owner is not root or the crontab owner's primary group, this is a finding.
#
#Fix Text: Change the group owner of the crontab file to root, cron, or the crontab's primary group.
#Procedure:
# chgrp root [crontab file]
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003050: Cron File Group Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN003050

#Start-Lockdown
find /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly /etc/cron.d /etc/crontab /etc/cron.allow ! -group root -type f -exec chgrp root {} \; > /dev/null

# Make sure user crons are owned by the user or root
for USERCRON in `find /var/spool/cron -type f`; do
  USERNAME=`basename $USERCRON`
  GROUPNAME=`id -g -n $USERNAME`
  find $USERCRON -type f ! -group $GROUPNAME ! -group root -exec chgrp $GROUPNAME {} \;
done

