module "github_oidc" {
  source = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 4.0"

  project_id = local.config.project_id
  pool_id = "github-workers-pool"
  provider_id = "github-provider"
  attribute_condition = "assertion.repository == \"${local.config.repo_name}\""

  sa_mapping = {
    (google_service_account.github_actions_service_account.account_id) = {
      sa_name = google_service_account.github_actions_service_account.name
      attribute = "attribute.repository/user/repo"
    }
  }

  depends_on = [ module.project_services, google_project_iam_member.opentofu_roles ]
}