#!/bin/sh

## (GEN000300: CAT II) (Previously – G033) The SA will ensure
## vendor recomended and required security patches are applied
echo '==================================================='
echo ' Checking GEN000120: RHN Patch Server Status'
echo '==================================================='
/usr/sbin/rhn_check
if [ $? -eq 0 ]; then
	/usr/bin/yum check-update
	if [ $? -eq 0 ]; then
		echo "System Patched by RHN Satellite."
	else
		echo "System Patched by RHN Satellite Updates Available."
	fi
else
	echo "System is either not registered or not communicating with RHN Satellite."
	echo
	echo "Please apply patches manually via DVD Process (see STIG-FIX Documentation)"
	echo
	if [ ! -e /etc/yum.repos.d/rhel-dvd.repo ]; then
		echo "Creating '/etc/yum.repos.d/rhel-dvd.repo' configuration... "
		cat > /etc/yum.repos.d/rhel-dvd.repo << EOF
# Created by STIG-FIX Script to help satisfy DISA STIG GEN000300 (CAT II)
# Apply patches manually via reposync/createrepo process in STIG-FIX Documentation
[rhel-dvd]
name=Red Hat Enterprise Linux $releasever - $basearch - DVD
baseurl=file:///media/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
		echo "Done."
	fi
fi
