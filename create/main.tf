
resource "linode_lke_cluster" "gaintplay-web-lke" {
  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region
  tags        = var.tags

  #  dynamic "pool" {
  # for_each = var.pools
  # content {
  #     type  = pool.value["type"]
  #     count = pool.value["count"]
  #     }
  # }
  pool {
    type  = var.instance_type
    count = var.number_of_instance
    autoscaler {
      min = var.min
      max = var.max
    }
  }

  # Prevent the count field from overriding autoscaler-created nodes
  lifecycle {
    ignore_changes = [
      pool.0.count
    ]
  }
}


//Export this cluster's attributes
output "kubeconfig" {
  value     = linode_lke_cluster.gaintplay-web-lke.kubeconfig
  sensitive = true
}
# resource "local_file" "private_key" {
#     content  = linode_lke_cluster.gaintplay-web-lke.kubeconfig
#     filename =  "${path.module}./config"
# }
resource "local_file" "private_key" {
  content  = base64decode(yamldecode(linode_lke_cluster.gaintplay-web-lke.kubeconfig))
  filename = "${path.module}/config"
}


output "api_endpoints" {
  value = linode_lke_cluster.gaintplay-web-lke.api_endpoints
}

output "status" {
  value = linode_lke_cluster.gaintplay-web-lke.status
}

output "id" {
  value = linode_lke_cluster.gaintplay-web-lke.id
}

output "pool" {
  value = linode_lke_cluster.gaintplay-web-lke.pool
}


# watchdog_enabled = true
# backups_enabled = true
# backups_schedule {
#     day = "Sundays"
#     window = "W0"
# }
# boot_config {
#     label = "gaintplay-web-lke"
#     kernel = "linode/latest-64bit"
#     root_device = "/dev/sda"
#     root_device_ro = false
#     helpers {
#         devtmpfs_automount = true
#         modules_dep = true
#         network = true
#     }
#     devices {
#         sda {
#             disk_id = linode_disk.gaintplay-web-lke.id
#             volume_id = linode_volume.gaintplay-web-lke.id
#         }
#     }
# }
