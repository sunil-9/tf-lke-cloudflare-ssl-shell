variable "service_name" {
  description = "service_name"
}

variable "token" {
  description = "Linode token"
}
variable "k8s_version" {
  description = "The Kubernetes version to use for this cluster. (required)"
}

variable "label" {
  description = "The unique label to assign to this cluster. (required)"
}

variable "region" {
  description = "The region where your cluster will be located. (required)"
}
variable "instance_type" {
  description = "type of instance"
}
variable "number_of_instance" {
  description = "desire number of instance"
}
variable "min" {
  description = "minimum number of instance"
}
variable "max" {
  description = "maximum number of instance"
}

variable "tags" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
  type        = list(string)
}

