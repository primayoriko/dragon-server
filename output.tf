output "gke_cluster_id" {
  value       = google_container_cluster.dragon_cluster.id
  description = "ID of GKE cluster"
}
