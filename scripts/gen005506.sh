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
# on 06-Feb-2012 to check for cbc entries before running fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22459
#Group Title: GEN005506
#Rule ID: SV-26752r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005506
#Rule Title: The SSH daemon must be configured to not use CBC ciphers.
#
#Vulnerability Discussion: The cipher-block chaining (CBC) mode of encryption as implemented in the SSHv2 protocol is vulnerable to chosen-plaintext attacks and must not be used.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for allowed ciphers.
# grep -i ciphers /etc/ssh/sshd_config | grep -v '^#'
#If no lines are returned, or the returned ciphers list contains any cipher that does ends with "cbc", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and remove any ciphers ending with "cbc". If necessary, add a "Ciphers" line.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005506

#Start-Lockdown
grep ',.*es.*-cbc' /etc/ssh/sshd_config > /dev/null
if [ $? -eq 0 ]; then
	echo '==================================================='
	echo ' Patching GEN005506: Removing CBC Ciphers from SSHD'
	echo '==================================================='
	sed -i 's/,aes128-cbc//g' /etc/ssh/sshd_config
	sed -i 's/,3des-cbc//g' /etc/ssh/sshd_config
	sed -i 's/,aes192-cbc//g' /etc/ssh/sshd_config
	sed -i 's/,aes256-cbc//g' /etc/ssh/sshd_config
fi
