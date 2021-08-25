#! /bin/bash

cp mobile.loadbalance.local.conf /etc/httpd/conf/extra
cp desktop.loadbalance.local.conf /etc/httpd/conf/extra

systemctl restart httpd
echo "127.0.0.1       mobile.loadbalance.local 
127.0.0.1       desktop.loadbalance.local" >> /etc/hosts

systemctl restart httpd


