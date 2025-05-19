output "kubernetes_cluster_name" {
  value = module.gke.cluster_name
}

output "kubernetes_cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "network_name" {
  value = module.networking.network_name
}

output "subnet_name" {
  value = module.networking.subnet_name
}