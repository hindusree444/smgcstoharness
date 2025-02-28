terraform {
  backend "gcs" {
    bucket = "stgcpharnesss1"  # GCS bucket where Terraform state will be stored
    prefix = "terraform/state"  # Path inside the bucket (optional)
  }
}

provider "google" {
  project     = "statemigration"        # GCP project ID
  region      = "us-central1"           # GCP region where resources will be created
  
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-gcp-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"  # GCP zone where the VM will be created

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20210114"  # Image to use for the VM
    }
  }

  network_interface {
    network = "default"
    access_config {  # Allocate a public IP
    }
  }
}
