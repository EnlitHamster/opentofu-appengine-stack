locals {
  config = yamldecode(file("/srv/config/config.yml"))

  gh_token_secret = "github_access_token"
  stack_version_secret = "stack_version"

  service_account_key_file = "/srv/config/${local.config.service_account_key_filename}"
}