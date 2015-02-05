#/bin/sh
## (LNX00600: CAT II) (Previously - L230) The SA wiil not configure the
## PAM configruation file to allow the first person to log in at the 
## console sole access to certian administrative privlages.
echo '==================================================='
echo ' Patching LNX00600: Console Permissions'
echo '==================================================='

find /etc/pam.d/ -type f | xargs sed -i '/pam_console.so/d'

if [ -a "/etc/security/console.perms" ]; then 
	rm -f /etc/security/console.perms
fi

find /etc/security/console.perms.d/ -type f -name '*.perms' -exec rm -f {} \;
