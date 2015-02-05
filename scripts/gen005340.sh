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
# on 06-Feb-2012 to look for both .mib files and the .txt files under 
# /usr/share/snmp/mibs that show up in nessus scans.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-995
#Group Title: MIB File Permissions
#Rule ID: SV-995r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005340
#Rule Title: Management Information Base (MIB) files must have mode 0640 or less permissive.
#
#Vulnerability Discussion: The ability to read the MIB file could impart special knowledge to an intruder or malicious user about the ability to extract compromising information about the system or network.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the modes for all Management Information Base (MIB) files on the system.
#
#Procedure:
# find / -name *.mib
# ls -lL <mib file>
#
#If any file is returned that does not have mode 0640 or less permissive, this is a finding.
#
#Fix Text: Change the mode of MIB files to 0640.
#
#Procedure:
# chmod 0640 <mib file>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005340: MIB File Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN005340

#Start-Lockdown
find / -name *.mib -type f -exec chmod u-xs,g-wxs,o-rwxt {} \;
if  [ -d /usr/share/snmp/mibs/ ]; then
	find /usr/share/snmp/mibs/ -type f -name '*.txt' -exec chmod u-xs,g-wxs,o-rwxt {} \;
fi
