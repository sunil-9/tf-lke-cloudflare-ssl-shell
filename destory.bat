@echo off;

cd install-ssl;
terraform destroy -force;
del  .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init  config loadbalancer_ip

cd ../dns_update;
terraform destroy -force;
del  .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init  config loadbalancer_ip

cd ../deploy;
terraform destroy -force;
@REM # remove the config file
del  .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init config loadbalancer_ip
del  ./modules/kubernetes/config

cd ../create;
terraform destroy -force;
@REM # remove the config file
del  .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init config



