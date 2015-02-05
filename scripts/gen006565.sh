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
#Group ID (Vulid): V-22506
#Group Title: GEN006565
#Rule ID: SV-26856r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006565
#Rule Title: The system package management tool must be used to verify system software periodically.
#
#Vulnerability Discussion: Verification using the system package management tool can be used to determine that system software has not been tampered with.
#
#This requirement is not applicable to systems that do not use package management tools.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Check the root crontab (crontab -l) and the global crontabs in /etc/crontab, /etc/cron.d/* for the presence of an rpm verification command such as:
#rpm -qVa | awk '$2!="c" {print $0}'
#If no such cron job is found, this is a finding.
#
#Fix Text: Add a cron job to run an rpm verification command such as:
#rpm -qVa | awk '$2!="c" {print $0}' 
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN006565: System Verification with RPM'
echo '==================================================='

#Global Variables#
PDI=GEN006565

#Start-Lockdown

# Create a simple solution that will keep track of changes without filling
# up the disk with a bunch of verify dumps. We will use logger if any changes
# are found to make it easy for someone to set up notifications.

# Make the log directory if it doesn't exist.
if [ ! -e /var/log/GEN006565 ]; then
	mkdir /var/log/GEN006565
	chown root:root /var/log/GEN006565
	chmod 700 /var/log/GEN006565
	restorecon -R -v /var/log/GEN006565
fi

# Create the script in /etc/cron.daily(run from /etc/crontab as specified
# in the STIG Check) to do the work.
if [ ! -e /etc/cron.daily/GEN006565.sh ]; then
	cat <<EOF > /etc/cron.daily/GEN006565.sh
#!/bin/bash

## Added to satify DISA STIG GEN006565

FILENAME=rpm_verify_\$(date +'%d-%b-%y')

if [ ! -e /var/log/GEN006565/\${FILENAME} ]; then
	rpm -qVa | awk '\$2!="c" {print \$0}' > /var/log/GEN006565/\${FILENAME}
fi

# Compare against the last check if it exists
if [ -e /var/log/GEN006565/LASTCHECK ]; then
	# If different keep the log and report, otherwise remove it.
	diff /var/log/GEN006565/LASTCHECK /var/log/GEN006565/\${FILENAME}
	if [ \$? -eq 0 ]; then
		ls -l /var/log/GEN006565/LASTCHECK | grep \${FILENAME} > /dev/null
		if [ \$? -ne 0 ]; then
			rm -f /var/log/GEN006565/\${FILENAME}
		fi
	else
		# Log the change
		logger -p auth.info "STIG check GEN006565 found differences when running an rpm verify.  Please review logs under /var/log/GEN006565."
 
		# Set the new link
		ln -f -s /var/log/GEN006565/\${FILENAME} /var/log/GEN006565/LASTCHECK
	fi
else
	# This is the first run, so create the LASTCHECK link
	ln -s /var/log/GEN006565/\${FILENAME} /var/log/GEN006565/LASTCHECK
fi
EOF
	chown root:root /etc/cron.daily/GEN006565.sh
	chmod 700 /etc/cron.daily/GEN006565.sh
fi
