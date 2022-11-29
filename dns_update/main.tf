resource "cloudflare_record" "clcreative-main-cluster" {
    zone_id = var.cloudflare_zone_id
    name = "${var.sub_domain}${var.domain_name}"
    value =  file("./loadbalancer_ip")
    type = "A"
    proxied = false
}