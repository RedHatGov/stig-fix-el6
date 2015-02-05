#!/bin/sh

## (GEN004540: CAT II) The SA will ensure the help sendmail command is
## disabled.
echo '==================================================='
echo ' Patching GEN004540: Disable sendmail help.'
echo '==================================================='
if [ -e /etc/mail/helpfile ]; then
	mv /etc/mail/helpfile /etc/mail/helpfile.bak
	echo "" > /etc/mail/helpfile
	sed -i '/HelpFile/s/^/#/' /etc/mail/sendmail.cf
fi
