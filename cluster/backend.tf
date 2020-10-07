terraform {
  backend "local" {
    path = "../states/cluster.tfstate"
  }
}
