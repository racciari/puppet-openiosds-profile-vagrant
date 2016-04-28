### Install Cyrus
yum -y install cyrus-imapd cyrus-sasl expect
systemctl enable cyrus-imapd.service saslauthd.service
systemctl start  cyrus-imapd.service saslauthd.service
# Init openio mailbox
CYRUS_PASSWD=$(mkpasswd -l 8 | tee /root/cyrus.passwd)
echo $CYRUS_PASSWD | passwd --stdin cyrus
echo "createmailbox user.openio"  | cyradm -u cyrus -w $CYRUS_PASSWD localhost
echo "setquota user.openio 10000" | cyradm -u cyrus -w $CYRUS_PASSWD localhost
