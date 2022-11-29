cd create
@REM # terraform destroy -auto-approve;
terraform init 
terraform plan -out terraform-init
@REM # terraform apply -auto-approve;
terraform apply terraform-init

@REM # //copy file "config" form . to ../deploy
copy config ..\deploy
echo [+] kubernetes cluster created successfully. 

cd ../deploy
terraform init 
terraform plan -out terraform-init 
@REM # terraform apply -auto-approve;
terraform apply terraform-init

copy config ..\dns_update

terraform output -raw ip_address > loadbalancer_ip

copy loadbalancer_ip ..\dns_update

echo [+] docker image application deployed successfully. 

cd ../dns_update

terraform init 
terraform plan -out terraform-init
terraform apply terraform-init

copy loadbalancer_ip ..\install-ssl
copy config ..\install-ssl

echo [+] cloudflare dns application deployed successfully. 

cd ../install-ssl
terraform init 
terraform plan -out terraform-init 
@REM # terraform apply -auto-approve;
terraform apply terraform-init

echo [+] ssl and nginx ingress installed and configured successfully successfully. 

cd ..
