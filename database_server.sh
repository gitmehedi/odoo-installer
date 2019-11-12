#!/bin/bash

echo -e "Application Server IP: "
read APP_IP

OE_USER="odoo"

#--------------------------------------------------
# Install
# wget https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
#--------------------------------------------------

sudo yum install wget vim -y

echo -e "\n---- Install PostgreSQL Server ----"
sudo wget https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm
sudo yum install pgdg-redhat10-10-2.noarch.rpm -y

sudo yum install postgresql10-server postgresql10 -y
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb

echo -e "\n---- PostgreSQL Settings  ----"
sudo sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /var/lib/pgsql/10/data/postgresql.conf

echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true

sudo sed -i s/"ident"/"trust"/g /var/lib/pgsql/10/data/pg_hba.conf
sudo sed -i s/"127.0.0.1"/"$APP_IP"/g /var/lib/pgsql/10/data/pg_hba.conf

sudo systemctl enable postgresql-10.service
sudo systemctl start postgresql-10.service

