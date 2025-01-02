output "github_actions_service_account_email" {
  value = google_service_account.github_actions_service_account.email
}

output "workload_identity_pool_provider_identifier" {
    value = module.github_oidc.provider_name
}