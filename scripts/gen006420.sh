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
# on 14-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12026
#Group Title: NIS Maps Domain Names
#Rule ID: SV-12527r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006420
#Rule Title: NIS maps must be protected through hard-to-guess domain names.
#
#Vulnerability Discussion: The use of hard-to-guess NIS domain names provides additional protection from unauthorized access to the NIS directory information.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
##
#Check Content: 
#Check the domain name for NIS maps.
#
#Procedure:
# domainname
#
#If the name returned is simple to guess, such as the organization name, building or room name, etc., this is a finding.
#
#Fix Text: Change the NIS domainname to a value difficult to guess. Consult vendor documentation for the required procedure.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006420

#Start-Lockdown

# Check that ypserv is installed first
rpm -q ypserv > /dev/null
if [ $? -eq 0 ]; then
	echo '==================================================='
	echo ' Patching GEN006420: NIS Maps Domain Names'
	echo '==================================================='

	DNAME=`cat /dev/urandom | tr -cd "[:upper:]" | head -c ${1:-10}`
	grep 'DOMAINNAME=' /etc/sysconfig/network > /dev/null
	if [ $? -ne 0 ]; then
		# Generate a random domainname
		echo "# Domainname added for STIG check $PDI" >> /etc/sysconfig/network
		echo "DOMAINNAME=$DNAME" >> /etc/sysconfig/network
	else
		sed -i -e "s/DOMAINNAME=.*/DOMAINNAME=${DNAME}/g" /etc/sysconfig/network
	fi

 	grep 'NISDOMAIN=' /etc/sysconfig/network > /dev/null
  	if [ $? -ne 0 ]; then
		# Generate a random domainname
		echo "# Domainname added for STIG check $PDI" >> /etc/sysconfig/network
		echo "NISDOMAIN=$DNAME" >> /etc/sysconfig/network
	else
		sed -i -e "s/NISDOMAIN=.*/NISDOMAIN=${DNAME}/g" /etc/sysconfig/network
	fi
fi
