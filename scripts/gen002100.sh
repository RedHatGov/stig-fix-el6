#!/bin/bash

## GEN002100: CAT II) The SA will ensure .rhosts is not supported in the pluggable
## authentication module (PAM).
echo '===================================================='
echo ' Patching GEN002100: Remove pam_rhosts_auth from PAM'
echo '===================================================='
`grep -q pam_rhosts_auth /etc/pam.d/*`
if [ $? -gt 0 ]; then
	for NAME in `grep -l pam_rhosts_auth /etc/pam.d/*`; do
		sed -i '/pam_rhosts_auth/d' $NAME
	done
fi
