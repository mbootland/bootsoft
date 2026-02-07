terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0" 
    }
  }
}

provider "google" {
  project = "bootsoft"
  region  = "asia-northeast1"
  credentials = file("bootsoft-ae33363f8a69.json")
}