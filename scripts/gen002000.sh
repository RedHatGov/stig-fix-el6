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
#Group ID (Vulid): V-913
#Group Title: A .netrc file exists
#Rule ID: SV-913r8_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002000
#Rule Title: There must be no .netrc files on the system.
#
#Vulnerability Discussion: Unencrypted passwords for remote FTP servers may be stored in .netrc files. Policy requires that passwords be encrypted in storage and not used in access scripts.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the system for the existence of any .netrc files.
#
#Procedure:
# find / -name .netrc
#
#If any .netrc file exists, this is a finding.
#
#Fix Text: Remove the .netrc file(s).
#
#Procedure:
# find / -name .netrc
# rm <.netrc file>
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002000: Remove .netrc Files'
echo '==================================================='

#Global Variables#
PDI=GEN002000

NETRCFILE=$( find / -name .netrc )

#Start-Lockdown
for FILE in $NETRCFILE; do
    rm -f $FILE
done

