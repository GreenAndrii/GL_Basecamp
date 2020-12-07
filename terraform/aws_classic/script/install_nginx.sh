#!/usr/bin/env bash

sudo apt-get -y update && sudo apt-get -y install nginx

host_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOF > /var/www/html/index.html
<h2>Server IP: $host_ip</h2>
EOF

sudo systemctl start nginx
