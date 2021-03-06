resource "google_container_cluster" "dragon_cluster" {
  name = "dragon-cluster"

  location                 = local.zone
  remove_default_node_pool = true

  min_master_version = local.kubernetes_version
  node_version       = local.kubernetes_version

  initial_node_count = local.gke_nodes_num

  release_channel {
    channel = "UNSPECIFIED"
  }
}

resource "google_container_node_pool" "dragon_cluster_node_pool" {
  name = "dragon-cluster-node-pool"

  cluster  = google_container_cluster.dragon_cluster.name
  location = local.zone

  node_count = local.gke_nodes_num
  node_locations = [
    local.zone,
  ]

  management {
    auto_repair  = false
    auto_upgrade = false
  }

  upgrade_settings {
    max_surge       = 0
    max_unavailable = 1
  }

  node_config {
    machine_type = local.node_machine_type

    disk_size_gb = 12
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["gke-node"]

    labels = {
      env = local.project_id
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
