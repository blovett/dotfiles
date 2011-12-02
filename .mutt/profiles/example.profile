# NAME: example
# DESC: example email profile

unset signature
set imap_user="user@domain"
set imap_pass=`~/.mutt/bin/fetch-gmail-password.sh user@domain"

set folder="imaps://imap.gmail.com:993"
set spoolfile="+INBOX"
set postponed="+[Gmail]/Drafts"

set sendmail="/usr/local/bin/msmtp -a example"

unmy_hdr *
my_hdr From: My Name <user@domain>

mailboxes =box1 =box2

source ~/.mutt/profiles/example.aliases

# vim:ts=3:et:ft=muttrc
