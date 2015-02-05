#!/bin/bash

## (GEN004560: CAT II) (Previously – G646) To help mask the e-mail version, 
## the SA will use the following in place of the original sendmail greeting 
## message: 
##   O SmtpGreetingMessage= Mail Server Ready ; $b

echo '==================================================='
echo ' Patching GEN004560: Set sendmail greeting message'
echo '==================================================='
if [ -e /etc/mail/sendmail.cf ]; then
sed -i '/SmtpGreetingMessage/ c\
O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf
fi
