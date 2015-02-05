#!/bin/bash

## (GEN002120: CAT II) (Previously – G069) The SA will ensure the /etc/shells 
## (or equivalent) file exits.
echo '==================================================='
echo ' Patching GEN002120: Set /etc/shells'
echo '==================================================='
cat <<EOF > /etc/shells
/bin/sh
/bin/bash
/sbin/nologin
/bin/tcsh
/bin/csh
EOF
