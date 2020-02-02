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
  source = "../packages/minecraftServerVanilla/build/distributions/minecraft_1.15.2-1_all.deb"
  bucket = google_storage_bucket.deb-storage.name
}