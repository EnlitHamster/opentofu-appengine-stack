locals {
  config = yamldecode(file("config.yml"))
  secrets = yamldecode(file("secrets.yml"))

  gh_token_secret = "github_access_token"
}