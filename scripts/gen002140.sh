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
#
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 16-jan-2012 to only add shells from /etc/passwd that are supposed to and 
# to remove existing bad shells from /etc/shells as well.


#Group ID (Vulid): V-917
#Group Title: The /etc/shells contents
#Rule ID: SV-917r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002140
#Rule Title: All shells referenced in /etc/passwd must be listed in the /etc/shells file, except any shells specified for the purpose of preventing logins.
#
#Vulnerability Discussion: The shells file lists approved default shells. It helps provide layered defense to the security approach by ensuring users cannot change their default shell to an unauthorized shell that may not be secure.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Confirm the login shells referenced in the /etc/passwd file are listed in the /etc/shells file.
#
#Procedure:
# for USHELL in `cut -d: -f7 /etc/passwd`; do if [ $(grep -c "${USHELL}" /etc/shells) == 0 ]; then echo "${USHELL} not in /etc/shells";fi done
#
#The /usr/bin/false, /bin/false, /dev/null, /sbin/nologin, /bin/sync, /sbin/halt, /sbin/shutdown, (and equivalents), and sdshell will be considered valid shells for use in the /etc/passwd file, but will not be listed in the /etc/shells file.
#
#If a shell referenced in /etc/passwd is not listed in the shells file, excluding the above mentioned shells, this is a finding.

#Fix Text: Use the "chsh" utility or edit the /etc/passwd file and correct the error by changing the default shell of the account in error to an acceptable shell name contained in the /etc/shells file.   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002140: Default Shells'
echo '==================================================='

#Global Variables#
PDI=GEN002140

#Start-Lockdown
for CURSHELL in `awk -F':' '{print $7}' /etc/passwd | sort | uniq`;do
  if [ "$CURSHELL" != "/usr/bin/false" -a "$CURSHELL" != "/bin/false" -a "$CURSHELL" != "/bin/null" -a "$CURSHELL" != "/sbin/nologin" -a "$CURSHELL" != "/bin/sync" -a "$CURSHELL" != "/bin/halt" -a "$CURSHELL" != "/bin/shutdown" -a "$CURSHELL" != "/bin/sdshell" ]; then
    grep "$CURSHELL" /etc/shells > /dev/null
    if [ $? -ne 0 ]; then
	echo $CURSHELL >> /etc/shells
    fi
  fi
done

# remove any that don't belong
for BADSHELL in /usr/bin/false /bin/false /dev/null /sbin/nologin /bin/sync /sbin/halt /sbin/shutdown sdshell; do

  grep "$BADSHELL" /etc/shells > /dev/null
  if [ $? -eq 0 ]; then
	sed -i -e "\:${BADSHELL}:d" /etc/shells
  fi
done
