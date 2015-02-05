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
# on 04-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-828
#Group Title: hosts.lpd ownership
#Rule ID: SV-828r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003920
#Rule Title: The printers.conf file must be owned by root.
#
#Vulnerability Discussion: Failure to give ownership of the printers.conf file to root provides the designated owner, and possible unauthorized users, with the potential to modify the printer.conf file. Unauthorized modifications could disrupt access to local printers from authorized remote hosts or permit unauthorized remote access to local printers.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the print service configuration file.
#
#Procedure:
# ls -lL /etc/cups/printers.conf;
#
#If no print service configuration file is found, this is not applicable.
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the owner of the /etc/cups/printers.conf to root.
#
#Procedure:
# chown root /etc/cups/printers.conf   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003920: Printer Ownership '
echo '==================================================='

#Global Variables#
PDI=GEN003920

#Start-Lockdown
if [ -a "/etc/cups/printers.conf" ]; then
  CUROWN=`stat -c %U /etc/cups/printers.conf`;
  if [ "$CUROWN" != "root" ]; then
      chown root /etc/cups/printers.conf
  fi
fi

