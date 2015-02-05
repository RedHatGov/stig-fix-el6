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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 08-jan-2012 to output an error in the standard error file if a hash
# is found in /etc/group.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22348
#Group Title: GEN001475
#Rule ID: SV-26447r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001475
#Rule Title: The /etc/group file must not contain any group password hashes.
#
#Vulnerability Discussion: Group passwords are typically shared and should not be used. Additionally, if password hashes are readable by non-administrators, the passwords are subject to attack through lookup tables or cryptographic weaknesses in the hashes.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the /etc/group file for password hashes.
# cut -d : -f 2 /etc/group | egrep -v '^(x|!)$'
#If any password hashes are returned, this is a finding.
#
#Fix Text: Edit /etc/group and change the password field to an exclamation point (!) to lock the group password.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001475

#Start-Lockdown
# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{if($2 != "x" && $2 != "*") print $1}' /etc/group | tr "\n" " "`  
if [ "$BADHASH" != "" ]; then
	echo '==================================================='
	echo ' Checking GEN001475: Password Hashes in /etc/group'
	echo '==================================================='
	echo "------------------------------"
	echo "$PDI: The following users have password hashes in the /etc/group file."
	echo
	echo "${BADHASH}"
	echo
	echo "------------------------------"
fi
