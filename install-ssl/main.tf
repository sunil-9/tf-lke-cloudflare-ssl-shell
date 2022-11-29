
resource "kubectl_manifest" "test" {
    yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-app-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    configuration-snippet: |
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
spec:
  tls:
    - hosts:
        - ${var.sub_domain}${var.domain_name}
      secretName: example-tls
  rules:
    - host: ${var.sub_domain}${var.domain_name}
      http:
        paths:
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: ${var.service_name}
                port:
                  number: 80
YAML
}
resource "kubectl_manifest" "challenge" {
  depends_on = [
    helm_release.ingress-cert-manager 
  ]
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: ${var.email}
    server: https://acme-v02.api.letsencrypt.org/directory
    # server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-secret-prod
    solvers:
    - http01:
        ingress:
          class: nginx
YAML
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "ingress-cert-manager" {
  depends_on = [
    kubernetes_namespace.cert-manager
  ]
  # chart      = "cert-manager/cert-manager"
  chart      = "cert-manager"
  name  = "cert-manager"
  repository = "https://charts.jetstack.io"
  namespace = kubernetes_namespace.cert-manager.metadata[0].name
  cleanup_on_fail = true
  # create_namespace = true
  # atomic = true
  reset_values = true
  wait_for_jobs = true
  timeout = 500
  # version = "v1.8.0"
  # set {
  #   name  = "serviceAccount.name"
  #   value = var.service_account
  # }
  set {
    name  = "installCRDs"
    value = "true"
  }
}
