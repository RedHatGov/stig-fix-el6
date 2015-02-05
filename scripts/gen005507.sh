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
#Group ID (Vulid): V-22460
#Group Title: GEN005507
#Rule ID: SV-26753r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005507
#Rule Title: The SSH daemon must be configured to only use message authentication codes (MACs) that employ FIPS 140-2 approved cryptographic hash algorithms.
#
#Vulnerability Discussion: DoD information systems are required to use FIPS 140-2 approved cryptographic hash functions.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check the SSH daemon configuration for allowed MACs.
#
#Procedure:
# grep -i macs /etc/ssh/sshd_config | grep -v '^#'
#
#If no lines are returned, or the returned MACs list contains any MAC other than "hmac-sha1", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and remove any MACs other than "hmac-sha1". If necessary, add a "MACs" line.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005507

#Start-Lockdown
grep -q "MACs hmac-sha1" /etc/ssh/sshd_config 2>/dev/null
if [ $? -ne 0 ]; then
	echo '==================================================='
	echo ' Patching GEN005507: Add MACs hmac-sha1 to SSHD'
	echo '==================================================='
	echo " " >> /etc/ssh/sshd_config
	echo "# For compliance of GEN005507 (FIPS 140-2)" >> /etc/ssh/sshd_config
	echo "MACs hmac-sha1" >> /etc/ssh/sshd_config
fi
