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
#  on 04-Feb-2012 to add a check for tcpdump, all related packages after 
# checking if they are installed and remove any binaries that match.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12049
#Group Title: Network Analysis tools are enabled.
#Rule ID: SV-12550r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003865
#Rule Title: Network analysis tools must not be installed.
#
#Vulnerability Discussion: Network analysis tools allow for the capture of network traffic visible to the system.
#
#Responsibility: System Administrator
#IAControls: DCPA-1
#
#Check Content: 
#Determine if any network analysis tools are installed.
#
#Procedure:
# find / -name ethereal
# find / -name wireshark
# find / -name tshark
# find / -name netcat
# find / -name tcpdump
# find / -name snoop
#
#If any network analysis tools are found, this is a finding.
#
#Fix Text: Remove each network analysis tool binary from the system. Remove items that are part of a package with a package manager, others remove the binary directly.
#
#Procedure:
#Find the binary file:
# find / -name <Item to be removed>
#
#Find the package, if any, to which it belongs:
# rpm -qf <binary file>
#
#Remove the package if it does not also include other software that is used:
# rpm -e <package name>
#or
# yum remove <package name>
#
#If the item to be removed is not in a package, or the entire package cannot be removed because of other software it provides, remove the item's binary file.
# rm <binary file>  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003865: Remove Network Anaylzers'
echo '==================================================='

#Global Variables#
PDI=GEN003865

#Start-Lockdown
for NETPKG in wireshark wireshark-gnome nc tcpdump nmap; do
	rpm -q $NETPKG
  	if [ $? -eq 0 ]; then
		rpm -e --nodeps $NETPKG
  	fi
done

find / -name wireshark -o -name wireshark -o -name wireshark-gnome -o -name nc -o -name tcpdump -o -name snoop -o -name tshark -o -name nmap -exec rm -f {} \; 
