terraform { required_version = ">= 0.12.13" }
provider tls { version = "~>2.2" }
provider google { version = "~> 3.42" }

data "google_client_config" "default" {}

provider kubernetes {
  load_config_file = false

  host                   = "https://${data.terraform_remote_state.cluster.outputs.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cacert)
  version                = "~> 1.13"
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.terraform_remote_state.cluster.outputs.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cacert)
  }
  version = "1.3.1"
}

output key {
  value = tls_private_key.root.private_key_pem
}

output cert {
  value = tls_self_signed_cert.root.cert_pem
}
