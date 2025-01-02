provider "google" {
  project = local.config.project_id
  region = local.config.location_id
  credentials = local.service_account_key_file
}

provider "google-beta" {
  project = local.config.project_id
  region = local.config.location_id
  credentials = local.service_account_key_file
}

data "google_project" "current_project" {
  project_id = local.config.project_id
}

data "google_service_account" "opentofu_service_account" {
  project = local.config.project_id
  account_id = local.config.service_account_name
}

resource "google_project_iam_member" "opentofu_roles" {
  project = local.config.project_id
  member = "serviceAccount:${data.google_service_account.opentofu_service_account.email}"

  for_each = toset(local.config.service_account_roles)
  role = each.value

  depends_on = [ module.project_services ]
}

resource "google_service_account" "github_actions_service_account" {
  project = local.config.project_id
  account_id = "github-actions-service-account"

  depends_on = [ module.project_services ]
}

resource "google_project_iam_member" "github_actions_service_account_roles" {
  project = local.config.project_id
  member = "serviceAccount:${google_service_account.github_actions_service_account.email}"

  for_each = toset([
    "roles/appengine.appAdmin",
    "roles/storage.admin",
    "roles/cloudbuild.builds.editor",
    "roles/iam.serviceAccountUser"
  ])
  role = each.value
}
