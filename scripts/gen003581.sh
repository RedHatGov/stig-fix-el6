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
#  - update by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-feb-2012 to add USERCTL=no to interfaces files who are missing the
# config.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22408
#Group Title: GEN003581
#Rule ID: SV-26620r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003581
#Rule Title: Network interfaces must not be configured to allow user control.
#
#Vulnerability Discussion: Configuration of network interfaces should be limited to privileged users. Manipulation of network interfaces may result in a denial of service or bypass of network security mechanisms.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the system for user-controlled network interfaces.
# grep -l '^USERCTL=yes' /etc/sysconfig/network-scripts/ifcfg*
#If any results are returned, this is a finding.
#
#Fix Text: Edit the configuration for the user-controlled interface and remove the "USERCTL=yes" configuration line or set to "USERCTL=no".   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003581: Remove user control of network'
echo '==================================================='

#Global Variables#
PDI=GEN003581

#Start-Lockdown
for NICCONF in `ls /etc/sysconfig/network-scripts/ifcfg*`; do
	grep USERCTL $NICCONF > /dev/null
	if [ $? -eq 0 ]; then
		sed -i 's/USERCTL=yes/USERCTL=no/g' $NICCONF
	else
		echo "USERCTL=no" >> $NICCONF
	fi
done
