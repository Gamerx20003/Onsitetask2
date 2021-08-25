#! /bin/bash


mkdir /srv/http/server1.com
mkdir /srv/http/server2.com

touch /srv/http/server1.com/index.html
touch /srv/http/server2.com/index.html

echo "<html>
  <head>
    <title>server1.com</title>
  </head>
  <body>
    <h1>Desktop Version</h1>
  </body>
</html>" >> /srv/http/server1.com/index.html

echo "<html>
  <head>
    <title>server2.com</title>
  </head>
  <body>
    <h1>Mobile Version</h1>
  </body>
</html>" >> /srv/http/server2.com/index.html

echo "Include conf/extra/httpd-vhosts.conf" >> /etc/httpd/conf/httpd.conf

echo "<VirtualHost *:80>
    ServerAdmin webmaster@server1.com
    DocumentRoot "/srv/http/server1.com"
    ServerName server1.com
    ServerAlias www.server1.com
    ProxyRequests off
    ProxyPreserveHost On

    <Proxy balancer://desk>
	BalancerMember http://localhost:8081
	BalancerMember http://localhost:8082
    </Proxy>

    ProxyPass      /desktop.loadbalance.local balancer://desk/
    ProxyPassReverse /desktop.loadbalance.local balancer://desk/
    ErrorLog "/var/log/httpd/server1.com-error_log"
    CustomLog "/var/log/httpd/server1.com-access_log" common
</VirtualHost>

<VirtualHost *:80>
    ServerAdmin webmaster@server2.com
    DocumentRoot "/srv/http/server2.com"
    ServerName server2.com
    ProxyRequests off
    ProxyPreserveHost On

    <Proxy balancer://mob>
	BalancerMember http://localhost:8083
	BalancerMember http://localhost:8084
    </Proxy>

    ProxyPass        /mobile.loadbalance.local balancer://mob/
    ProxyPassReverse /mobile.loadbalance.local balancer://mob/
    ErrorLog "/var/log/httpd/server2.com-error_log"
    CustomLog "/var/log/httpd/server2.com-access_log" common
</VirtualHost>" >> /etc/httpd/conf/extra/httpd-vhosts.conf

systemctl restart httpd

echo "127.0.0.1       localhost
127.0.0.1       server1.com
127.0.0.1       server2.com
127.0.0.1       mobile.loadbalance.local 
127.0.0.1       desktop.loadbalance.local
#Virtual Hosts 
12.34.56.789   server1.com
12.33.44.555   server2.com" >> /etc/hosts

systemctl restart httpd


