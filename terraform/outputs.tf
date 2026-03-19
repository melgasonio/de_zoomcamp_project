output "dataset_id" {
  value       = google_bigquery_dataset.main.dataset_id
  description = "The BigQuery dataset ID"
}

output "dataset_self_link" {
  value       = google_bigquery_dataset.main.self_link
  description = "Link to the dataset in GCP Console"
}