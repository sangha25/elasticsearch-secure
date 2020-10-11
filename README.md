# Encrypt communication among Elasticsearch, Kibana, and Logstash. After the setup, Elasticsearch and Kibana can be accessed by web browsers via https.
By updating with appropriate hosts details, and running anisble-playbook -K site.yml , We will have the running instance of Elasticsearch.
Follow below step-by-step instructions on how to encrypt communication among Elasticsearch, Kibana, and Logstash.
# Step 1: Using self-sign CA generate from Elasticsearch:
>> cd /usr/share/elasticsearch  #where we have all the elasticsearch tools

>> bin/elasticsearch-certutil ca  #Here we will use elasticsearch-certutil to generate our own self signed certificate to secure elasticsearch , You are prompted for an output filename and a password.

# Generate a certificate and private key for each node in your cluster.
>> bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12

# Optional: Generate additional certificates specifically for encrypting HTTP client communications.
>> bin/elasticsearch-certutil http

# Copy the node certificate to the appropriate locations.
mkdir -p /etc/elasticsearchts/cer
cp /usr/share/elasticsearch/elastic-certificates.p12 /etc/elasticsearch/certs

# Encrpyting communications between nodes in a cluster

Add the following lines in the Elasticsearch configuration file. In my case, the path is /etc/elasticsearch/elasticsearch.yml 

http.host: 0.0.0.0 # accept request from remote
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: certs/elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: certs/elastic-certificates.p12
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/elastic-certificates.p12
xpack.security.http.ssl.truststore.path: certs/elastic-certificates.p12
xpack.security.http.ssl.client_authentication: optional

Restart Elasticsearch service to make sure the above changes take effect and no error occurred at this point.




