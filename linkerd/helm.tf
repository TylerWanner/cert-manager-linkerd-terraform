resource "helm_release" "linkerd" {
  name       = "linkerd"
  chart      = "linkerd2"
  repository = "https://helm.linkerd.io/stable"
  version    = "2.8.1"
  values = [
    file("values-ha.yaml")
  ]
  set_sensitive {
    name  = "global.identityTrustAnchorsPEM"
    value = data.terraform_remote_state.cm.outputs.cert
  }
  set {
    name  = "identity.issuer.scheme"
    value = "kubernetes.io/tls"
  }
  set {
    name  = "installNamespace"
    value = "false"
  }
}
