resource "tls_private_key" "root" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "root" {
  key_algorithm   = tls_private_key.root.algorithm
  private_key_pem = tls_private_key.root.private_key_pem

  validity_period_hours = 87600
  early_renewal_hours   = 2190

  is_ca_certificate = true

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
  ]

  subject {
    common_name = "identity.linkerd.cluster.local"
  }
}
