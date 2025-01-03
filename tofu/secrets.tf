data "google_iam_policy" "opentofu_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:${data.google_service_account.opentofu.email}"]
  }
}

resource "random_password" "database_user_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_secret_manager_secret" "stack_version" {
  secret_id = local.stack_version_secret

  replication {
    auto {}
  }

  depends_on = [module.project_services, google_project_iam_member.opentofu]
}

resource "google_secret_manager_secret_version" "stack_version" {
  secret      = google_secret_manager_secret.stack_version.id
  secret_data = random_id.stack_version.dec
}

resource "google_secret_manager_secret_iam_policy" "stack_version" {
  secret_id   = google_secret_manager_secret.stack_version.id
  policy_data = data.google_iam_policy.opentofu_secretAccessor.policy_data
}

resource "google_secret_manager_secret" "database_user_password" {
  secret_id = local.database_user_password_secret

  replication {
    auto {}
  }

  depends_on = [module.project_services, google_project_iam_member.opentofu]
}

resource "google_secret_manager_secret_version" "database_user_password" {
  secret      = google_secret_manager_secret.database_user_password.id
  secret_data = random_password.database_user_password.result
}

resource "google_secret_manager_secret_iam_policy" "database_user_password" {
  secret_id   = google_secret_manager_secret.database_user_password.id
  policy_data = data.google_iam_policy.opentofu_secretAccessor.policy_data
}
