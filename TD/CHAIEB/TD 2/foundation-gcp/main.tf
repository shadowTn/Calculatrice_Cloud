provider "google" {
  project = "Projet_TD2"
  region  = "europe-west9"
}

# Création de VPC 
resource "google_compute_network" "td_vpc" {
  name = "td-vpc"
}

# Création de VM
resource "google_compute_instance" "td_vm" {
  name         = "td-vm"
  machine_type = "n2-standard-2"
  zone         = "europe-west9-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network       = google_compute_network.td_vpc.id
    access_config {}
  }
}

# Base de donnée
resource "google_sql_database_instance" "td_db" {
  name             = "td-db"
  database_version = "POSTGRES_16"
  region           = "europe-west9"

  settings {
    tier = "db-f1-micro"
  }
}

# DNS
resource "google_dns_managed_zone" "kiowy_zone" {
  name     = "kiowy-zone"
  dns_name = "kiowy.com."   # your actual domain
}

# enregistrement DNS A
resource "google_dns_record_set" "td_dns_record" {
  name         = "www.${google_dns_managed_zone.kiowy_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.kiowy_zone.name
  rrdatas      = [google_compute_instance.td_vm.network_interface[0].access_config[0].nat_ip]
}
