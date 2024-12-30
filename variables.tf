locals {
  config = yamldecode(file("config.yml"))

  gh_token_secret = "github_access_token"
}