output "github_actions_service_account_email" {
  description = "The email for GitHub Workflows setup for access through the Workload Identity Pool"
  value = google_service_account.github_actions.email
}

output "workload_identity_pool_provider_identifier" {
  description = "The full identifier of the Workload Identity Provider needed to setup GitHub Auth Action"
  value = module.github_oidc.provider_name
}

output "production_database_instance_connection_name" {
  description = "The instance connection name to use with Cloud SQL Auth Proxy and Connectors"
  value = google_sql_database_instance.production.connection_name
}

output "production_database_name" {
  description = "The name of the production database"
  value = google_sql_database.main.name
}

output "production_database_user_name" {
  description = "The database user's username with access to the production database"
  value = google_sql_user.appengine.name
}

output "production_database_user_password" {
  description = "The database user's password"
  value     = google_sql_user.appengine.password
  sensitive = true
}
