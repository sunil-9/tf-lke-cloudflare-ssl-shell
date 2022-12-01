
resource "kubernetes_secret" "docker_secret" {
  metadata {
    name = "docker-cfg"
  }

  data = {
    ".dockerconfigjson" = file("./secret/docker-sec.json")
  }

  type = "kubernetes.io/dockerconfigjson"
}


resource "kubernetes_deployment" "beta" {
  depends_on = [
    kubernetes_secret.docker_secret
  ]
  metadata {
    name      = var.deploy_name
    namespace = "default"
  }
  spec {
    replicas = var.desire_replicas
    selector {
      match_labels = {
        app = var.deploy_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.deploy_name
        }
      }
      spec {
        image_pull_secrets {
          name = kubernetes_secret.docker_secret.metadata[0].name
        }
        container {
          image_pull_policy = "Always"
          image             = var.image_link
          name              = var.image_name
          port {
            container_port = var.image_port
          }
          resources {
            # limits = {
            #   cpu    = "500m"
            #   memory = "1000Mi"
            # }
            requests = {
              cpu    = "500m"
              memory = "1000Mi"
            }
          }

        }
      }
    }
  }
}


# resource "kubernetes_horizontal_pod_autoscaler" "example" {
#   metadata {
#     name = "terraform-example"
#   }
#   spec {
#     max_replicas = 10
#     min_replicas = 3
#     scale_target_ref {
#       kind = "Deployment"
#       name = var.deploy_name
#     }
#   }
# }

# resource "kubernetes_horizontal_pod_autoscaler_v2beta2" "example" {
#   metadata {
#     name = "auto-scale"
#   }

#   spec {
#     min_replicas = var.min_replicas_val
#     max_replicas = var.max_replicas_val

#     scale_target_ref {
#       kind = "Deployment"
#       name = var.deploy_name
#     }

#     behavior {
#       scale_down {
#         stabilization_window_seconds = 300
#         select_policy                = "Min"
#         policy {
#           period_seconds = 120
#           type           = "Pods"
#           value          = 1
#         }

#         policy {
#           period_seconds = 310
#           type           = "Percent"
#           value          = 100
#         }
#       }
#       scale_up {
#         stabilization_window_seconds = 600
#         select_policy                = "Max"
#         policy {
#           period_seconds = 180
#           type           = "Percent"
#           value          = 100
#         }
#         policy {
#           period_seconds = 600
#           type           = "Pods"
#           value          = 5
#         }
#       }
#     }
#   }
# }


resource "kubernetes_service_v1" "example" {
  metadata {
    name = var.service_name
  }
  spec {
    selector = {
      app = var.deploy_name
    }
    port {
      port        = 80
      target_port = var.image_port
      protocol    = "TCP"
    }
    type = var.ip_type
  }
}



resource "helm_release" "ingress" {
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  # set enable-real-ip=true in  config app to get real ip
  set {
    name  = "controller.config.enable-real-ip"
    value = "true"
  }
  set {
    name  = "controller.config.use-forwarded-headers"
    value = "true"
  }
  # set {
  #   name  = "controller.config.use-proxy-protocol"
  #   value = "true"
  # }
}

data "kubernetes_service" "ingress_svc" {
  depends_on = [
    helm_release.ingress
  ]
  metadata {
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-proxy-protocol" = "v2"
    }
    name = "ingress-nginx-controller"
  }
}
output "ip_address" {
  value = data.kubernetes_service.ingress_svc.status.0.load_balancer.0.ingress[0].ip
}

