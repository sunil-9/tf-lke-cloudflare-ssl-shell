#!/bin/bash

cd create;
# terraform destroy -auto-approve;
terraform init >> /dev/null;
terraform plan -out terraform-init;
# terraform apply -auto-approve;
terraform apply terraform-init;

# //copy file "config" form . to ../deploy
cp config ../deploy
echo [+] kubernetes cluster created successfully. 

cd ../deploy;
terraform init >> /dev/null;
terraform plan -out terraform-init ;
# terraform apply -auto-approve;
terraform apply terraform-init;

cp config ../dns_update

terraform output -raw ip_address > loadbalancer_ip

cp loadbalancer_ip ../dns_update

echo [+] docker image application deployed successfully. 

cd ../dns_update;

terraform init >> /dev/null;
terraform plan -out terraform-init;
terraform apply terraform-init;

cp loadbalancer_ip ../install-ssl
cp config ../install-ssl

echo [+] cloudflare dns application deployed successfully. 

cd ../install-ssl;
terraform init >> /dev/null;
terraform plan -out terraform-init ;
# terraform apply -auto-approve;
terraform apply terraform-init;

echo [+] ssl and nginx ingress installed and configured successfully successfully. 
