module "github_oidc" {
  source = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 4.0"

  project_id = local.config.project_id

  // Use a stack version to provision a new pool and provider, as destroying them does not free the ID up for 30 days.
  pool_id = "gh-pool-${google_secret_manager_secret_version.stack_version_secret_version.secret_data}"
  provider_id = "gh-prov-${google_secret_manager_secret_version.stack_version_secret_version.secret_data}"
  attribute_condition = "assertion.repository == \"${local.config.repo_name}\""

  sa_mapping = {
    (google_service_account.github_actions_service_account.account_id) = {
      sa_name = google_service_account.github_actions_service_account.name
      attribute = "attribute.repository/user/repo"
    }
  }

  depends_on = [ module.project_services, google_project_iam_member.opentofu_roles ]
}