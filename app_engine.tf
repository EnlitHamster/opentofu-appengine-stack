resource "google_app_engine_application" "app" {
  project = local.config.project_id
  location_id = "europe-west4"
}