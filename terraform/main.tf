module "networking" {
  source       = "./modules/networking"
  project_id   = var.project_id
  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
  region       = var.region
}

module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
  network_name = module.networking.network_name
  subnet_name  = module.networking.subnet_name
  node_pools   = var.node_pools
}