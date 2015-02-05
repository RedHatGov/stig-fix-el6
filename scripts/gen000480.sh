#!/bin/sh

## (GEN000480: CAT II) (Previously – G015) The SA will ensure the logon delay between
## logon prompts after a failed logon is set to at least four seconds.
echo '==================================================='
echo ' Patching GEN000480: Set logon delay to 4 seconds.'
echo '==================================================='

`/bin/grep -q FAIL_DELAY /etc/login.defs`
if [ $? -gt 0 ]; then
cat >> /etc/login.defs << EOF
# Set the delay after failed login attempts to 4 seconds.
FAIL_DELAY	4
EOF
fi
