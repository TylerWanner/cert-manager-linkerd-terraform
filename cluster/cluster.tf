resource "google_container_cluster" "cluster" {
  name                     = "l5d-cert-manager-demo"
  min_master_version       = "1.17.9"
  remove_default_node_pool = true

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count = 1

  # Setting an empty username and password explicitly disables basic auth
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}
resource "google_container_node_pool" "nodes" {

  name_prefix        = "pool"
  location           = google_container_cluster.cluster.location
  cluster            = google_container_cluster.cluster.name
  initial_node_count = 2

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 4
  }


  node_config {
    preemptible = true
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
      node_metadata = "SECURE"
    }
    machine_type = "e2-standard-2"
  }
}
