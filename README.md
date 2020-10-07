# Provisioning Linkerd Service Mesh with Cert-Manager on GCP/ GKE using Terraform + Helm

This walkthrough will create a GKE Cluster running cert-manager and Linkerd service mesh, with cert-manager being used to rotate the certificate used by Linkerd's identity service for mTLS

Requirements: Terraform, GCP credentials with permission to create a project, gcloud CLI
Tested with: [Terraform](https://www.terraform.io/downloads.html) v0.12.23, [google cloud provider](https://www.terraform.io/docs/providers/google/index.html) v3.26, [gcloud CLI](https://cloud.google.com/sdk/docs/install) v288.0.0

## To run:

You can use an environment variable to set which service account key to use during provisioning `export GOOGLE_APPLICATION_CREDENTIALS=/path/to/key`--otherwise, it will use the shell's gcloud config

The GCP account you use must belong to a GCP project that has the necessary APIs enabled (such as billing and resource manager)--if it does not, you may have to enable these APIs manually along the way in those projects

1. traverse into the cluster directory, run `terraform init` and `terraform apply`--it will ask you for a project to use. This will create a GKE cluster in that project

2. Next, init and apply in the cert_manager directory. Now we have an active cert-manager running in our cluster

3. Do the same in the issuers directory, and it will create Issuer and Certificate CRDs that cert-manager will manage and Linkerd will use for linkerd-identity

4. init and apply in the linkerd dir, which will do a helm install of the linkerd control plane with HA values
