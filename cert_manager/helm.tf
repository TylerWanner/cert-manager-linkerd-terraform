resource "helm_release" "cm" {
  name             = "cm"
  namespace        = "cert-manager"
  create_namespace = true
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v0.16"
  values = [
    "${file("values.yaml")}"
  ]
}
