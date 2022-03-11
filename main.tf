resource "google_container_cluster" "ta_cluster" {
  name = "ta-cluster"

  location                 = local.region
  remove_default_node_pool = true

  min_master_version = "1.19.16-gke.6800"
  node_version       = "1.19.16-gke.6800"

  initial_node_count = local.gke_nodes_num

  release_channel {
    channel = "UNSPECIFIED"
  }
}

resource "google_container_node_pool" "ta_playground_node_pool" {
  name     = "ta-cluster-node-pool"
  location = local.region
  cluster  = google_container_cluster.ta_cluster.name

  node_count = local.gke_nodes_num
  node_locations = [
    local.zone,
  ]

  management {
    auto_repair  = false
    auto_upgrade = false
  }

  node_config {
    machine_type = local.node_machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["gke-node"]

    labels = {
      env = local.project_id
    }

    # metadata = {
    #     disable-legacy-endpoints = "true"
    # }
  }
}
