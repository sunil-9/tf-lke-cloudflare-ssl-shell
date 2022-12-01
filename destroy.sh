#!/bin/bash
cd install-ssl;
terraform destroy -auto-approve;
rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init  config loadbalancer_ip

cd ../dns_update;
terraform destroy -auto-approve;
rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init  config loadbalancer_ip

cd ../deploy;
terraform destroy -auto-approve;
# remove the config file
rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init config loadbalancer_ip
rm -rf ./modules/kubernetes/config

cd ../create;
terraform destroy --auto-approve;
# remove the config file
rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl terraform-init config



