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
# on 02-jan-2011 to add content and move from dev to prod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4427
#Group Title: Access Control Files Host Pairs
#Rule ID: SV-4427r8_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002020
#Rule Title: All .rhosts, .shosts, or host.equiv files must only contain trusted host-user pairs.
#
#Vulnerability Discussion: The Berkeley r-commands are legacy services which allow cleartext remote access and have an insecure trust model and should never be used. However, if there has been a documented exception made for their use and the files are not properly configured, they could allow malicious access by unknown malicious users from untrusted hosts who could compromise the system.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Locate and examine all .rhosts, .shosts, hosts.equiv, and shosts.equiv files.
#
#Procedure:
# find / -name .rhosts
# more /<directorylocation>/.rhosts
#
# find / -name .shosts
# more /<directorylocation>/.shosts
#
# find / -name hosts.equiv
# more /<directorylocation>/hosts.equiv
#
# find / -name shosts.equiv
# more /<directorylocation>/shosts.equiv
#
#If any .rhosts, .shosts, hosts.equiv, or shosts.equiv file contains other than host-user pairs, this is a finding.
#
#Fix Text: If possible, remove the .rhosts, .shosts, hosts.equiv, and shosts.equiv files. If the files are required, remove any content from the files except for necessary host-user pairs.  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN02020: Remove Remote Access Control'
echo '==================================================='

#Global Variables#
PDI=GEN002020

#Start-Lockdown

# We are just going to remove these for the initial security run, but users
# may not want to run this if they are using the old rhosts.  If you are 
# still using these, you may want to look into using the secure ssh 
# alternatives.
find / \( -name '.rhosts' -o -name '.shosts' -o -name 'hosts.equiv' -o -name 'shosts.equiv' \) -exec rm -f {} \;


