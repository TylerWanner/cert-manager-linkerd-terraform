terraform {
  backend "local" {
    path = "../linkerd.tfstate"
  }
}
data "terraform_remote_state" "cluster" {
  backend = "local"

  config = {
    path = "../cluster.tfstate"
  }
}

data "terraform_remote_state" "cm" {
  backend = "local"

  config = {
    path = "../states/cert_manager.tfstate"
  }
}
