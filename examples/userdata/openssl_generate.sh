#! /bin/bash
exec > >(tee /var/log/user-data-openssl.log|logger -t user-data-openssl -s 2>/dev/console) 2>&1

S3_BUCKET=$1
ROUTE53_SERVER=$2

echo "Set Server"
JENKINS_SERVER=${ROUTE53_SERVER}

echo "Generate Openssl Certificates"
export OPENSSL_CONF="/opt/jenkins/packages/conf/openssl.conf"
sudo ldconfig -v
source ~/.bashrc
sudo /opt/jenkins/packages/apache*/bin/openssl genrsa -out samlkeyfile.key 4096
sudo /opt/jenkins/packages/apache*/bin/openssl req -new -key samlkeyfile.key -subj "/CN=$JENKINS_SERVER/O=Jenkins Softare/C=US" -config $OPENSSL_CONF -out samlcsrfile.csr
sudo /opt/jenkins/packages/apache*/bin/openssl x509 -req -days 365 -in samlcsrfile.csr -signkey samlkeyfile.key -out samlcertfile.crt 
sudo chmod u=rw,g=r,o=r samlkeyfile.key
echo "Copy files to a directory for Jenkins to use"
sudo mkdir /var/optjenkins/data/saml 
sudo mv saml* /var/opt/jenkins/data/saml/
echo "Copy SAML certificates to S3"
sudo aws s3 cp /var/opt/jenkins/data/saml/samlcertfile.crt s3://${S3_BUCKET}/jenkins/saml/
sudo aws s3 cp /var/opt/jenkins/data/saml/samlcsrfile.csr s3://${S3_BUCKET}/jenkins/saml/
sudo aws s3 cp /var/opt/jenkins/data/saml/samlkey.key s3://${S3_BUCKET}/jenkins/saml/