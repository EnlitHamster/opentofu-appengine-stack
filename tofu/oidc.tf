module "github_oidc" {
  source = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 4.0"

  project_id = local.config.project_id
  pool_id = "github-workers-pool"
  provider_id = "github-provider"
  attribute_condition = "assertion.repository == \"${local.config.repo_name}\""

  sa_mapping = {
    (data.google_service_account.opentofu_service_account.account_id) = {
      sa_name = data.google_service_account.opentofu_service_account.name
      attribute = "attribute.repository/user/repo"
    }
  }

  depends_on = [ module.project_services, google_project_iam_member.opentofu_roles ]
}