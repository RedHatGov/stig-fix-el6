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
# on 15-jan-2012 to add the .dt* checks and fix the find permission values.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-905
#Group Title: Local Initialization Files Permissions
#Rule ID: SV-905r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001880
#Rule Title: All local initialization files must have mode 0740 or less permissive.
#
#Vulnerability Discussion: Local initialization files are used to configure the user's shell environment upon login. Malicious modification of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the modes of local initialization files.
#Procedure:
# ls -al /<usershomedirectory>/.login
# ls -al /<usershomedirectory>/.cschrc
# ls -al /<usershomedirectory>/.logout
# ls -al /<usershomedirectory>/.profile
# ls -al /<usershomedirectory>/.bash_profile
# ls -al /<usershomedirectory>/.bashrc
# ls -al /<usershomedirectory>/.bash_logout
# ls -al /<usershomedirectory>/.env
# ls -al /<usershomedirectory>/.dtprofile (permissions should be 0755)
# ls -al /<usershomedirectory>/.dispatch
# ls -al /<usershomedirectory>/.emacs
# ls -al /<usershomedirectory>/.exrc
# find /<usershomedirectory>/.dt ! -fstype nfs \( -perm -0002 -o -perm -0020 \) -exec ls -ld {} \; (permissions not to be more
#permissive than 0755)
#
#If local initialization files are more permissive than 0740 or the .dt directory is more permissive than 0755 or the .dtprofile file is more permissive than 0755, this is a finding.
#
#Fix Text: Ensure user startup files have permissions of 0740 or more restrictive. Examine each user’s home directory and verify that all file names that begin with "." have access permissions of 0740 or more restrictive. If they do not, use the chmod command to correct the vulnerability.
#
#Procedure:
# chmod 0740 <dot filename>
#
#Note: The period is part of the file name and is required.   
#######DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001880: Initialization File Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN001880

#Start-Lockdown
find $(awk -F: '{ print $6 }' /etc/passwd|sort|uniq|grep -v '^/$') -maxdepth 1 -type f \( -name .login -o -name .cshrc -o -name .logout -o -name .profile -o -name .bashrc -o -name .bash_logout -o -name .bash_profile -o -name .bash_login -o -name .env -o -name .dispatch -o -name .emacs -o -name .exrc \) -perm /7037 -exec chmod u-s,g-wxs,o-rwxt {} \;

find $(awk -F: '{ print $6 }' /etc/passwd|sort|uniq|grep -v '^/$') -maxdepth 1 \( -name .dt -o -name .dtprofile \) -perm /7022 -exec chmod u-s,g-ws,o-wt {} \;

