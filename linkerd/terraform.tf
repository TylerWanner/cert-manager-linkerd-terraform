terraform { required_version = ">= 0.12.13" }
provider google { version = "~> 3.42" }
data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${data.terraform_remote_state.cluster.outputs.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cacert)
  }
  version = "1.3.0"
}
