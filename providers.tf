provider "google" {
  project = local.config.project_id
  credentials = local.config.service_account_key_file
  region = local.config.location_id
}