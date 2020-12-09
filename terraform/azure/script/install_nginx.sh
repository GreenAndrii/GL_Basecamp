#!/usr/bin/env bash
sudo apt-get -y update && sudo apt-get -y install nginx
host_ip=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/privateIpAddress?api-version=2017-04-02&format=text")
cat <<EOF > /var/www/html/index.html
<h2>Server IP: $host_ip</h2>
EOF
sudo systemctl start nginx