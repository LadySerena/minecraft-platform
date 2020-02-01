provider "google" {
  project = "minecraft-server-tiede"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_compute_image" "prometheus_image" {
  name = "packer-1580593262"
  project = "minecraft-server-tiede"
}

resource "google_storage_bucket" "deb-storage" {
    name = "deb-package-bucket"
    location = "US"
    labels = {
        "minecraft" = "true"
    }
}

resource "google_storage_bucket_object" "prometheus-deb" {
  name   = "prometheus.deb"
  source = "../packages/prometheus/build/distributions/prometheus_2.14.0-1_amd64.deb"
  bucket = google_storage_bucket.deb-storage.name
}

resource "google_storage_bucket_object" "node-exporter-deb" {
  name   = "node-exporter.deb"
  source = "../packages/nodeExporter/build/distributions/node-exporter_0.18.1-1_amd64.deb"
  bucket = google_storage_bucket.deb-storage.name
}

resource "google_storage_bucket_object" "minecraft-server-deb" {
  name   = "minecraft.deb"
  source = "../packages/minecraftServerVanilla/build/distributions/minecraft_1.15.1-1_all.deb"
  bucket = google_storage_bucket.deb-storage.name
}

resource "google_compute_firewall" "prometheus_rules" {
  name    = "telemetry-firewall"
  network = google_compute_network.prometheus_network.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }

  allow {
    
    protocol = "tcp"
    ports    = ["9090"]
  }
}

resource "google_compute_network" "prometheus_network" {
  name = "serena-minecraft-telemtry-network"
  delete_default_routes_on_create = false
}

resource "google_compute_instance" "prometheus_1" {
  name         = "prometheus"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["prometheus"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.prometheus_image.name
    }
  }

  network_interface {
    network = google_compute_network.prometheus_network.name
    access_config {
    
    }
  }
}


