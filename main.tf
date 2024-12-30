resource "google_project" "energy_trade" {
  name = local.config.project_name
  project_id = local.config.project_id
}

resource "google_app_engine_application" "app" {
  project = google_project.energy_trade.project_id
  location_id = "europe-west4"
}
