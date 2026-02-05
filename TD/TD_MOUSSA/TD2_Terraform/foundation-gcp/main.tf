resource "google_storage_bucket" "bucket_td2" {
  name     = "${var.project_id}-td2-bucket"
  location = var.region
}