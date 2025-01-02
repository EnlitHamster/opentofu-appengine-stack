locals {
  config = yamldecode(file("/srv/config/config.yml"))

  gh_token_secret               = "github_access_token"
  stack_version_secret          = "stack_version"
  database_user_password_secret = "database_user_password"

  service_account_key_file = "/srv/config/${local.config.service_account_key_filename}"
}
