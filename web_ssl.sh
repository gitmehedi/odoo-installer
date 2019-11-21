# http -> https
server {
        listen 9000 ssl;
        server_name ndctoglw02.mutualtrustbank.com;

        client_max_body_size 4096M;
        proxy_read_timeout 720s;
        proxy_connect_timeout 720s;
        proxy_send_timeout 720s;

        # Add Headers for odoo proxy mode
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto "http";
        proxy_set_header X-Real-IP $remote_addr;

        # SSL parameters
        ssl on;
        ssl_certificate /etc/ssl/nginx/certificate.crt;
        ssl_certificate_key /etc/ssl/nginx/private-key.pem;
        ssl_session_timeout 1m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
        ssl_prefer_server_ciphers on;
        ssl_session_tickets off;

        # log
        access_log /var/log/nginx/odoo.access.log;
        error_log /var/log/nginx/odoo.error.log;

         # Redirect longpoll requests to odoo longpolling port

        location / {
            proxy_pass http://10.46.20.24:8010;
        }

        location /longpolling {
           proxy_pass http://10.46.20.24:8072;
        }

        # common gzip
        gzip_types text/css text/less text/plain text/xml application/xml application/json application/javascript;
        gzip on;
}