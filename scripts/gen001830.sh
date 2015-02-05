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
#Group ID (Vulid): V-22358
#Group Title: GEN001830
#Rule ID: SV-26477r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001830
#Rule Title: All skeleton files (typically in /etc/skel) must be group-owned by root, bin, sys, system, or other.
#
#Vulnerability Discussion: If the skeleton files are not protected, unauthorized personnel could change user startup parameters and possibly jeopardize user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the skeleton files are group-owned by root.
#
#Procedure:
# ls -alL /etc/skel
#If a skeleton file is not group-owned by root, this is a finding.
#
#Fix Text: Change the group-owner of the skeleton file to root, bin, sys, system, or other.
#
#Procedure:
# chgrp <group> /etc/skel/[skeleton file]
#or:
# ls -L /etc/skel|xargs stat -L -c %G:%n|egrep -v "^(root|bin|sy|sytem|other):"|cut -d: -f2|chgrp root
#will change the group of all files not already one of the approved group to root.   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001830: /etc/skel Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001830
BADSKELGRP=$( find /etc/skel/ ! -group root ! -group bin )

#Start-Lockdown
for FILE in $BADSKELGRP; do
	if [ -e $FILE ]; then
		chgrp root $FILE
	fi
done

