terraform {
  backend "local" {
    path = "../states/cert-manager.tfstate"
  }
}
data "terraform_remote_state" "cluster" {
  backend = "local"

  config = {
    path = "../states/cluster.tfstate"
  }
}
