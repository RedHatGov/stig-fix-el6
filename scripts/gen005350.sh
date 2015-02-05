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
#Group ID (Vulid): V-22450
#Group Title: GEN005350
#Rule ID: SV-26726r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005350
#Rule Title: Management Information Base (MIB) files must not have extended ACLs.
#
#Vulnerability Discussion: The ability to read the MIB file could impart special knowledge to an intruder or malicious user about the ability to extract compromising information about the system or network.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the file permissions for the MIB files.
# find / -name *.mib
# ls -lL <mib file>
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <mib file>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005350
MIBFILES=$( find / -name *.mib -print )

#Start-Lockdown
if [ ! -z $MIBFILES ]; then
	echo '==================================================='
	echo ' Patching GEN005350: Remove ACLs from MIB Files'
	echo '==================================================='
	for LINE in $MIBFILES; do
		if [ -a $LINE ];  then
			ACLOUT=`getfacl --skip-base $LINE 2>/dev/null`
			if [ "$ACLOUT" != "" ]; then
				setfacl --remove-all $LINE
			fi
		fi
	done
fi
