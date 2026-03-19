provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_path)
}

resource "google_bigquery_dataset" "main" {
  dataset_id  = "de_zoomcamp"
  location    = var.region
  description = "Dataset for DE Zoomcamp project"
}