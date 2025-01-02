output "github_actions_service_account_email" {
  value = google_service_account.github_actions_service_account.email
}

output "workload_identity_pool_provider_identifier" {
  value = module.github_oidc.provider_name
}

output "production_database_name" {
  value = google_sql_database.database.name
}

output "production_database_instance_connection_name" {
  value = google_sql_database_instance.production.connection_name
}

output "production_database_user_name" {
  value = google_sql_user.appengine_user.name
}

output "production_database_user_password" {
  value     = google_sql_user.appengine_user.password
  sensitive = true
}
