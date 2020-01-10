#!/bin/bash
  
SERVER_1=192.168.56.103
SERVER_2=192.168.56.104
USERNAME=node
FILENAME=/var/lib/postgresql/10/replication/recovery.conf
ODOO_CONF=/Users/beast/software/odoo/conf/mtb_dev.conf
#ODOO_CONF=/opt/odoo/server/conf/10.0/mtb_dev.conf

S1_OK=0
S2_OK=0

if  grep -F "$SERVER_1" "$ODOO_CONF"
then
   CUR_MASTER=$SERVER_1
elif  grep -F $SERVER_2 $ODOO_CONF
then
   CUR_MASTER=$SERVER_2
fi

ssh $USERNAME@$SERVER_1  test -f  $FILENAME && ((S1_OK++))
if [ $S1_OK == 1 ]
then
 NEW_MASTER=$SERVER_1
fi

ssh $USERNAME@$SERVER_2  test -f  $FILENAME && ((S2_OK++))
if [ $S2_OK == 1 ]
then
 NEW_MASTER=$SERVER_2
fi

echo -e "$CUR_MASTER == $NEW_MASTER"
if [ "$CUR_MASTER" != "$NEW_MASTER" ]
then
 sed -i s/"$CUR_MASTER"/"$NEW_MASTER "/g $ODOO_CONF
 kill -9 $(ps -ef | grep odoo | awk '{print $2}')
 /Users/beast/software/odoo/server/10.0/odoo-bin -c $ODOO_CONF
fi
