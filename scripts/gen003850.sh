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
#  - Updated Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-Feb-2012 to disable kerberized and non-kerberized telnet servers


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-24386
#Group Title: GEN003850
#Rule ID: SV-30063r1_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN003850
#Rule Title: The telnet daemon must not be running.
#
#Vulnerability Discussion: The telnet daemon provides a typically unencrypted remote access service which does not provide for the confidentiality and integrity of user passwords or the remote session. If a privileged user were to log on using this service, the privileged user password could be compromised.
#
#Responsibility: System Administrator
#IAControls: DCPP-1
#
#Check Content: 
#The telnet service included in the RHEL5 distribution is part of krb5-workstation. There are two versions of telnetd server provided. The xinetd.d file ekrb5-telnet allows only connections authenticated through kerberos. The xinetd.d krb5-telnet allows normal telnet connections as well as kerberized connections. Both are set to "disable = yes" by default. Ensure that niether is running.
#
#Procedure:
#Check if telnetd is running
#ps -ef |grep telnetd
#If the telnet daemon is running, this is a finding.
#
#Check if telnetd is enabled on startup
#grep "disable.*no" /etc/xinetd/d/*telnet
#If an entry with "disable = no" is found, this is a finding.
#
#
#Fix Text: identify the telnet service running and disable it.
#
#Procedure
#Find the service name of the telnet daemon:
#egrep "disable.*no" /etc/xinetd.d/*.telnet|dirname $(cut -d: -f1)
#
#disable the telnet server:
#chkconfig <telnetd service name> off
#
#verify the telnet daemon is no longer running:
#ps -ef |grep telnet
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003850

#Start-Lockdown
#Check if telnet installed
if [ -e /etc/xinetd.d/ ]; then
	echo '==================================================='
	echo ' Patching GEN003850: Disable Telnet Daemon'
	echo '==================================================='
	for TELNETCONF in `ls /etc/xinetd.d/ | grep telnet`; do
		if [ -e $TELNETCONF ]; then
			sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' $TELNETCONF
		fi
	done
fi
