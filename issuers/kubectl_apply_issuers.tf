resource "null_resource" "issuers" {
  provisioner "local-exec" {
    command = <<EOF
      gcloud container clusters get-credentials ${data.terraform_remote_state.cluster.outputs.cluster_name} \
      --zone ${data.terraform_remote_state.cluster.outputs.zone} --project ${data.terraform_remote_state.cluster.outputs.project}
      kubectl apply -f issuer_l5d.yaml
      kubectl apply -f l5d_id_certificate.yaml
EOF
  }
}
