provider google {
  project = var.project
  zone    = var.zone
  version = "~> 3.42"
}

output cluster_endpoint {
  value = google_container_cluster.cluster.endpoint
}

output cacert {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}

output project {
  value = var.project
}

output zone {
  value = var.zone
}

output cluster_name {
  value = google_container_cluster.cluster.name
}
