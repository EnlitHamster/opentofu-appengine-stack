resource "google_secret_manager_secret" "stack_version_secret" {
  secret_id = local.stack_version_secret

  replication {
    auto {}
  }

  depends_on = [module.project_services, google_project_iam_member.opentofu_roles]
}

resource "google_secret_manager_secret_version" "stack_version_secret_version" {
  secret      = google_secret_manager_secret.stack_version_secret.id
  secret_data = random_id.stack_version.dec
}

data "google_iam_policy" "opentofu_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:${data.google_service_account.opentofu_service_account.email}"]
  }
}

resource "google_secret_manager_secret_iam_policy" "stack_version_secret_policy" {
  secret_id   = google_secret_manager_secret.stack_version_secret.id
  policy_data = data.google_iam_policy.opentofu_secretAccessor.policy_data
}
