# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     name = "monitoring"
#   }
# }
# resource "helm_release" "prometheus" {
#   depends_on = [
#     kubernetes_namespace.monitoring
#   ]
#   chart      = "prometheus"
#   name       = "prometheus"
#   namespace  = "monitoring"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   version    = "15.5.3"

#   set {
#     name  = "podSecurityPolicy.enabled"
#     value = true
#   }

#   set {
#     name  = "server.persistentVolume.enabled"
#     value = false
#   }

#   # You can provide a map of value using yamlencode. Don't forget to escape the last element after point in the name
#   set {
#     name = "server\\.resources"
#     value = yamlencode({
#       limits = {
#         cpu    = "200m"
#         memory = "50Mi"
#       }
#       requests = {
#         cpu    = "100m"
#         memory = "30Mi"
#       }
#     })
#   }
# }

# resource "kubernetes_secret" "grafana_login" {
#     depends_on = [
#     kubernetes_namespace.monitoring
#   ]
#   metadata {
#     name      = "grafana"
#     namespace = "monitoring"
#   }

#   data = {
#     admin-user     = "admin"
#     admin-password = "adminUser@123"
#   }
# }

# resource "random_password" "grafana" {
#   length = 24
# }

# resource "helm_release" "grafana-monitoring" {
#     depends_on = [
#     kubernetes_namespace.monitoring
#   ]
#   chart      = "grafana"
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   namespace  = "monitoring"
#   version    = "6.24.1"

#   values = [
#     templatefile("${path.module}/templates/grafana-values.yaml", {
#       admin_existing_secret = kubernetes_secret.grafana_login.metadata[0].name
#       admin_user_key        = "admin-user"
#       admin_password_key    = "admin-password"
#       prometheus_svc        = "${helm_release.prometheus.name}-server"
#       replicas              = 1
#     })
#   ]
# }
