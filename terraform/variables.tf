variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "auto-scaling-platform"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "auto-scaling-platform-network"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "auto-scaling-platform-subnet"
}

variable "subnet_cidr" {
  description = "The CIDR for the subnet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_pools" {
  description = "List of node pool configurations"
  type = list(object({
    name         = string
    machine_type = string
    min_count    = number
    max_count    = number
    disk_size_gb = number
    preemptible  = bool
    labels       = map(string)
  }))
  default = [
    {
      name         = "general-pool"
      machine_type = "e2-standard-2"
      min_count    = 1
      max_count    = 5
      disk_size_gb = 100
      preemptible  = false
      labels       = { "pool" = "general" }
    },
    {
      name         = "high-cpu-pool"
      machine_type = "e2-highcpu-4"
      min_count    = 0
      max_count    = 3
      disk_size_gb = 100
      preemptible  = true
      labels       = { "pool" = "high-cpu" }
    }
  ]
}