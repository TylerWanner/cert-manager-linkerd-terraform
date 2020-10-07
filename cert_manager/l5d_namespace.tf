resource "kubernetes_namespace" "linkerd" {
  metadata {
    name = "linkerd"
  }
}

resource "kubernetes_secret" "linkerd" {
  metadata {
    name      = "linkerd-trust-anchor"
    namespace = kubernetes_namespace.linkerd.metadata[0].name
  }
  data = {
    "tls.crt" = tls_self_signed_cert.root.cert_pem
    "tls.key" = tls_private_key.root.private_key_pem
  }
  type = "kubernetes.io/tls"
}
