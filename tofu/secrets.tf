data "google_secret_manager_secret" "database_user_password" {
  secret_id = local.database_user_password_secret
}

data "google_secret_manager_secret_version" "database_user_password" {
  secret = data.google_secret_manager_secret.database_user_password.id
}
