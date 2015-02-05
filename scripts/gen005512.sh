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
#Group ID (Vulid): V-22463
#Group Title: GEN005512
#Rule ID: SV-26756r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005512
#Rule Title: The SSH client must be configured to only use message authentication codes (MACs) that employ FIPS 140-2 approved cryptographic hash algorithms.
#
#Vulnerability Discussion: DoD information systems are required to use FIPS 140-2 approved cryptographic hash functions.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check the SSH client configuration for allowed MACs.
# grep -i macs /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the returned MACs list contains any MAC other than "hmac-sha1", this is a finding.
#
#Fix Text: Edit the SSH client configuration and remove any MACs other than "hmac-sha1". If necessary, add a "MACs" line.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005512

#Start-Lockdown
grep -q "MACs hmac-sha1" /etc/ssh/ssh_config 2>/dev/null
if [ $? -ne 0 ]; then
	echo '==================================================='
	echo ' Patching GEN005512: Add MACs hmac-sha1 to SSH'
	echo '==================================================='
	echo " " >> /etc/ssh/ssh_config
	echo "# For compliance of GEN005512 (FIPS 140-2)" >> /etc/ssh/ssh_config
	echo "MACs hmac-sha1" >> /etc/ssh/ssh_config
fi
