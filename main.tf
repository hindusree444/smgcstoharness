terraform {
  backend "gcs" {
    bucket         = "stgcpharnesss1"   # Ensure this bucket exists
    prefix         = "terraform/state"  # Optional, but helps in organizing state
    region         = "us-central1"
    encrypt        = true
    # Optional: state locking, if you want to add locking mechanism, you can add Firestore as a lock backend
  }
}

provider "google" {
  project     = "statemigration"       # Ensure this project exists
  region      = "us-central1"          # Ensure this region is correct
  credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY_JSON>")  # Harness service account credentials
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-gcp-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20210114"
    }
  }

  network_interface {
    network = "default"
    access_config {  # Allocate a public IP
    }
  }
}
