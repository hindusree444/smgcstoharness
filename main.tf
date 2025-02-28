terraform {
  backend "s3" {
    bucket         = "stgcpharnesss1"            
    key            = "terraform/statefile/terraform.tfstate"  
    region         = "us-central1"                      
    encrypt        = true                              
  }
}
provider "google" {

  project     = "statemigration"                               
  region      = "us-central1"                                     
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


