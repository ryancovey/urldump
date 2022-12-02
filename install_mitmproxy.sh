#!/bin/bash

wget https://snapshots.mitmproxy.org/6.0.2/mitmproxy-6.0.2-linux.tar.gz
wget https://raw.githubusercontent.com/ryancovey/urldump/master/urldump
wget https://raw.githubusercontent.com/ryancovey/urldump/master/mitmproxy_wrapper
tar -xvzf mitmproxy-6.0.2-linux.tar.gz

cp mitmdump urldump mitmproxy_wrapper /usr/bin
chmod +x /usr/bin/urldump /usr/bin/mitmproxy_wrapper

timeout 5s sudo urldump

cp /root/.mitmproxy/mitmproxy-ca-cert.cer /etc/pki/ca-trust/source/anchors/
update-ca-trust

su - ec2-user -c 'conda config --set ssl_verify /etc/pki/ca-trust/source/anchors/mitmproxy-ca-cert.cer'
