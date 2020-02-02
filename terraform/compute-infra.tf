provider "google" {
  project = "minecraft-server-tiede" #Your Project Here
  region  = "us-central1" #Preferred Region Here
  zone    = "us-central1-c" #Preferred Zone Here
  version = "~> 3.6"
}

data "google_compute_image" "prometheus_image" {
  name = "prometheus-1580672357"
  project = "minecraft-server-tiede"
  
}

data "google_compute_image" "minecraft_image" {
  name = "minecraft-1580675994"
  project = "minecraft-server-tiede"
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

resource "google_compute_firewall" "minecraft_rules" {
  name    = "minecraft-firewall"
  network = google_compute_network.minecraft_network.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }

  allow {
    
    protocol = "tcp"
    ports    = ["22","25565"]
  }
}

resource "google_compute_network" "prometheus_network" {
  name = "serena-minecraft-telemtry-network"
  delete_default_routes_on_create = false
}

resource "google_compute_network" "minecraft_network" {
  name = "serena-minecraft-server-network"
  delete_default_routes_on_create = false
}

resource "google_compute_instance" "prometheus_1" {
  name         = "prometheus"
  machine_type = "e2-micro"
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

resource "google_compute_instance" "minecraft_1" {
  name         = "minecraft"
  machine_type = "e2-medium"
  scheduling {
      preemptible  = true
      automatic_restart = false
  }
  zone         = "us-central1-a"

  tags = ["minecraft"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.minecraft_image.name
    }
  }

  network_interface {
    network = google_compute_network.minecraft_network.name
    access_config {
    
    }
  }
}