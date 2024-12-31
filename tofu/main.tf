provider "google" {
  project = local.config.project_id
  region = local.config.location_id
  credentials = local.config.service_account_key_file
}

provider "google-beta" {
  project = local.config.project_id
  region = local.config.location_id
  credentials = local.config.service_account_key_file
}

data "google_project" "current_project" {
  project_id = local.config.project_id
}

data "google_service_account" "opentofu_service_account" {
  project = local.config.project_id
  account_id = local.config.service_account_name
}

resource "google_project_iam_member" "opentofu_storage_admin" {
  project = local.config.project_id
  member = "serviceAccount:${data.google_service_account.opentofu_service_account.email}"

  for_each = toset(local.config.service_account_roles)
  role = each.value
}
