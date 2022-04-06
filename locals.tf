locals {
  project_id = "stei-rpl-13518146"
  region     = "us-central1"
  zone       = "us-central1-a"

  gke_nodes_num     = 3
  node_machine_type = "e2-standard-4"

  kubernetes_version = "1.19.16-gke.11000"
}
