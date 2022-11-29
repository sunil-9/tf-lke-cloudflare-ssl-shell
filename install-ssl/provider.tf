terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"

    }
  }
}
provider "kubernetes" {
  config_path = pathexpand("${path.module}/config")
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("${path.module}/config")
  }
}

provider "kubectl" {
  config_path = pathexpand("${path.module}/config")
}