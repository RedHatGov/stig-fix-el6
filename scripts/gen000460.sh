#!/bin/sh

## (GEN000460: CAT II) (Previously – G013) The SA will ensure, after three consecutive
## failed logon attempts for an account, the account is locked for 15 minutes or until
## the SA unlocks the account.
echo '==================================================='
echo ' GEN000460: Disable after 3 consecutive'
echo '            failed attempts per account'
echo '==================================================='
# Configuration now part of apply.sh - uses the following files:
#  - config/system-auth-local > /etc/pam.d/system-auth-local > /etc/pam.d/system-auth
#  - config/password-auth-local > /etc/pam.d/password-auth-local > /etc/pam.d/system-auth
#  - config/gnome-screensaver /etc/pam.d/gnome-screensaver

# auth config overwrites these changes, make it non executable
chmod a-x /usr/sbin/authconfig
chmod a-x /usr/share/authconfig.py
