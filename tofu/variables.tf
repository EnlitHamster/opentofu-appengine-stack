locals {
  config = yamldecode(file("/srv/config/config.yml"))
  secrets = yamldecode(file("/srv/config/secrets.yml"))

  gh_token_secret = "github_access_token"
  service_account_key_file = "/srv/config/${local.config.service_account_key_filename}"
}