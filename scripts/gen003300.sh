#!/bin/bash

## (GEN003300: CAT II) (Previously – G212) The SA will ensure the at.deny file
## is not empty.
echo '==================================================='
echo ' Patching GEN003300: Set at.deny file'
echo '==================================================='
echo -n > /etc/at.deny
for NAME in `cut -d: -f1 /etc/passwd`; do
        NAMEID=`id -u $NAME`
        if [ $NAMEID -lt 500 -a $NAME != 'root' ]; then
                echo $NAME >> /etc/at.deny
        fi
done;

