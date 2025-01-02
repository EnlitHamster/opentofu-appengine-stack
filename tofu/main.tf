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

resource "random_id" "stack_version" {
  byte_length = 8
}

resource "google_secret_manager_secret" "stack_version_secret" {
  secret_id = local.stack_version_secret

  replication {
    auto {}
  }
  
  depends_on = [ module.project_services, google_project_iam_member.opentofu_roles ]
}

resource "google_secret_manager_secret_version" "stack_version_secret_version" {
  secret = google_secret_manager_secret.stack_version_secret.id
  secret_data = random_id.stack_version.dec
}

data "google_iam_policy" "opentofu_secretAccessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:${data.google_service_account.opentofu_service_account.email}"]
  }
}

resource "google_secret_manager_secret_iam_policy" "stack_version_secret_policy" {
  secret_id = google_secret_manager_secret.stack_version_secret.id
  policy_data = data.google_iam_policy.opentofu_secretAccessor.policy_data
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
    "roles/iam.serviceAccountUser",
    "roles/iam.workloadIdentityUser"
  ])
  role = each.value
}
