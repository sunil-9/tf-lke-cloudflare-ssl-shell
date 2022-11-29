variable "service_name" {
  description = "service_name"
}


#  ####### mudule => deploy_image
variable "deploy_name" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "desire_replicas" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "image_link" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "image_name" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "image_port" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "ip_type" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "max_replicas_val" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
}
variable "min_replicas_val" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
  default     = 1
}

#  ####### mudule => deploy_image end



