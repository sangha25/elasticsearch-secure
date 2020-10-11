#! /bin/bash
cd /usr/share/elasticsearch
bin/elasticsearch-certutil ca
bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12 -name "CN=$HOSTNAME,OU=Consulting Team,DC=your_domain_name,DC=com"
bin/elasticsearch-setup-passwords auto
mkdir -p /etc/elasticsearch/certs
cp /usr/share/elasticsearch/elastic-certificates.p12 /etc/elasticsearch/certs
