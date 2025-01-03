module "github_oidc" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 4.0"

  project_id = local.config.project_id

  // Use a stack version to provision a new pool and provider, as destroying them does not free the ID up for 30 days.
  pool_id             = "gh-pool-${random_id.stack_version.dec}"
  provider_id         = "gh-prov-${random_id.stack_version.dec}"
  attribute_condition = "assertion.repository == \"${local.config.repo_name}\""

  sa_mapping = {
    (google_service_account.github_actions.account_id) = {
      sa_name   = google_service_account.github_actions.name
      attribute = "attribute.repository/${local.config.repo_name}"
    }
  }

  depends_on = [module.project_services, google_project_iam_member.opentofu]
}
