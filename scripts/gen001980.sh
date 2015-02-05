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
# on 16-jan-2012 to have it remove netgroup entries from the access control
# files and not ACLs.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11987
#Group Title: Plus (+) in Access Control Files
#Rule ID: SV-12488r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001980
#Rule Title: The .rhosts, .shosts, hosts.equiv, shosts.equiv, /etc/passwd, /etc/shadow, and/or /etc/group files must not contain a plus (+) without defining entries for NIS+ netgroups.
#
#Vulnerability Discussion: The Berkeley r-commands are legacy services which allow cleartext remote access and have an insecure trust model and should never be used. However, if there has been a documented exception made for their use a plus (+) in system accounts files causes the system to lookup the specified entry using NIS. The /etc/passwd, /etc/shadow or /etc/group should also be checked for plus (+) entries. If the system is not using NIS, no such entries should exist.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check system configuration files for plus (+) entries.
#
#Procedure:
# find / -name .rhosts
# grep + /<directorylocation>/.rhosts
#
# find / -name .shosts
# grep + /<directorylocation>/.shosts
#
# find / -name hosts.equiv
# grep + /<directorylocation>/hosts.equiv
#
# find / -name shosts.equiv
# grep + /<directorylocation>/shosts.equiv
#
# grep + /etc/passwd
# grep + /etc/shadow
# grep + /etc/group
#
#If the .rhosts, .shosts, hosts.equiv, shosts.equiv, /etc/passwd, /etc/shadow, and/or /etc/group files contain a plus (+) and do not define entries for NIS+ netgroups, this is a finding.
#
#Fix Text: Edit the .rhosts, .shosts, hosts.equiv, shosts.equiv, /etc/passwd, /etc/shadow, and/or /etc/group files and remove entries containing a plus (+).
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001980: Plus (+) in Access Control'
echo '                     Files'
echo '==================================================='

#Global Variables#
PDI=GEN001980

#Start-Lockdown
for ACF in `find / -name .rhosts -o -name .shosts -o -name hosts.equiv -o -name shosts.equiv` /etc/passwd /etc/shadow /etc/group; do
	grep '^+' $ACF > /dev/null
	if [ $? -eq 0 ]; then
		sed -i -e '/^\+/d' $ACF
	fi
done
