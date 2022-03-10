output "GKE_cluster_id" {
    value = google_container_cluster.ta_cluster.id
    description = "id of GKE cluster"
}
