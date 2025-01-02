provider "google" {
  project     = local.config.project_id
  region      = local.config.location_id
  credentials = local.service_account_key_file
}

provider "google-beta" {
  project     = local.config.project_id
  region      = local.config.location_id
  credentials = local.service_account_key_file
}

data "google_project" "current_project" {
  project_id = local.config.project_id
}

resource "random_id" "stack_version" {
  byte_length = 8
}
