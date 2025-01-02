/// Ref: https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_host_programmatically

resource "google_secret_manager_secret" "github_token_secret" {
  secret_id = local.gh_token_secret

  replication {
    auto {}
  }
  
  depends_on = [ module.project-services, google_project_iam_member.opentofu_roles ]
}

resource "google_secret_manager_secret_version" "github_token_secret_version" {
  secret = google_secret_manager_secret.github_token_secret.id
  secret_data = local.secrets.github_personal_access_token
}

data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:service-${data.google_project.current_project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
  }
}

resource "google_secret_manager_secret_iam_policy" "github_token_secret_policy" {
  secret_id = google_secret_manager_secret.github_token_secret.id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}

resource "google_cloudbuildv2_connection" "github_repo" {
  location = local.config.location_id
  name = "github-${local.config.project_id}-connection"

  github_config {
    app_installation_id = local.secrets.github_cloud_build_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
    }
  }

  depends_on = [ google_secret_manager_secret_iam_policy.github_token_secret_policy, module.github-oidc ]
}
