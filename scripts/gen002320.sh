#!/bin/sh

## (GEN002320: CAT II) (Previously – G501) The SA will ensure the audio devices
## have permissions of 644, or more restrictive.
echo '==================================================='
echo ' Patching GEN002320: Setting permissions on audio'
echo '                     devices.'
echo '==================================================='
# prevent pam from changing the owner when logging in
if [ -e /etc/security/console.perms.d/50-default.perms ]; then
	sed -i -r "/sound|snd|mixer/ d" /etc/security/console.perms.d/50-default.perms
fi
# have udev set the permissions/owner/group
echo "SUBSYSTEM==\"sound|snd\", OWNER=\"root\", GROUP=\"root\", MODE=\"0644\"" > /etc/udev/rules.d/55-audio-perms.rules
