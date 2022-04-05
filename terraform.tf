terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = local.project_id
  region  = local.region
}
