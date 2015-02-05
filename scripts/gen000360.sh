#!/bin/bash

## (GEN0000360: CAT II) (Previously – G029) The SA will ensure
## that gids 0-99 (0-499 for Linux) are reserved for system
## accounts. If used, the exceptions (detailed above) must be
## documented with the IAO
echo '==================================================='
echo ' Patching GEN0000360: System UIDs and GIDs'
echo '==================================================='
# Default Red Hat, handled by login.defs
