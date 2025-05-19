provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_version = ">= 1.0.0"
  
  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "terraform/state"
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

