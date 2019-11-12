#!/bin/bash
#--------------------------------------------------
# Configuration Settings
#--------------------------------------------------

echo "Application Server IP (Ex: 192.168.1.1): "
read APP_SERVER

#--------------------------------------------------
# Download Nginx 
# wget http://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-1.14.2-1.el7_4.ngx.x86_64.rpm
#--------------------------------------------------
yum install wget -y


echo -e "\n --- Donwload nginx and install in Redhat 7 ---"
wget http://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-1.14.2-1.el7_4.ngx.x86_64.rpm
yum install nginx-1.14.2-1.el7_4.ngx.x86_64.rpm -y

echo -e "\n --- Configure nginx with OS ---"
systemctl enable nginx
systemctl start nginx

echo "" > /etc/nginx/conf.d/default.conf

echo "
server {
         listen 9000;
         server_name appserver.com;
         client_max_body_size 4096M;
         proxy_read_timeout 720s;
         proxy_connect_timeout 720s;
         proxy_send_timeout 720s;

         # Add Headers for odoo proxy mode
         proxy_set_header X-Forwarded-Host \$host;
         proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto \$scheme;
         proxy_set_header X-Real-IP \$remote_addr;

         location / {
             proxy_pass "http://$APP_SERVER:8010";
        }
         location /longpolling {
            proxy_pass "http://$APP_SERVER:8072";
        }

}" >> /etc/nginx/conf.d/default.conf

echo -e "\n--- A server in hosts file ---"
echo -e "$APP_SERVER appserver.com appserver" >> /etc/hosts

echo -e "\n --- NGINX Server Configuration Reload and Restart NGINX --- "
systemctl daemon-reload
systemctl restart nginx

echo -e "\n --- Response from NGINX server --- "
