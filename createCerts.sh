# create private key for CA
openssl genrsa -out ca.key 4096

# create self-signed certificate for CA
openssl req -x509 -new -nodes -key ca.key -days 3650 -subj '/CN=MyCA/OU=myOrgUnit/O=myOrg/L=myLocality/ST=myState/C=US' -out ca.crt

# create private key for server and server certificate request
openssl req -newkey rsa:4096 -days 3650 -nodes -subj '/CN=localhost/OU=myOrgUnit/O=myOrg/L=myLocality/ST=myState/C=US' -out server.csr -keyout server.key

# create server certificate signed by CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650 -extfile <(echo -e "keyUsage = digitalSignature, keyEncipherment\nextendedKeyUsage = serverAuth")

# create server private key and certificate in one PKCS #12 file
cat server.key server.crt > server.pem

# create private key for client and client certificate request
openssl req -newkey rsa:4096 -days 3650 -nodes -subj '/CN=X509client/OU=myOrgUnit/O=myOrg/L=myLocality/ST=myState/C=US' -out client.csr -keyout client.key

# create client certificate signed by CA
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 3650 -extfile <(echo -e "keyUsage = digitalSignature, keyEncipherment\nextendedKeyUsage = clientAuth")

# create client private key and certificate in one PKCS #12 file
cat client.key client.crt > client.pem

mkdir tls

mv ca.key tls/
mv ca.srl tls/
mv client.crt tls/
mv client.csr tls/
mv client.key tls/
mv server.crt tls/
mv server.csr tls/
mv server.key tls/
