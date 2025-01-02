data "google_service_account" "opentofu_service_account" {
  project    = local.config.project_id
  account_id = local.config.service_account_name
}

resource "google_project_iam_member" "opentofu_roles" {
  project = local.config.project_id
  member  = "serviceAccount:${data.google_service_account.opentofu_service_account.email}"

  for_each = toset(local.config.service_account_roles)
  role     = each.value

  depends_on = [module.project_services]

  # Give time to the IAM roles to be effective to avoid WIF erroring due to missing permissions.
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "google_service_account" "github_actions_service_account" {
  project    = local.config.project_id
  account_id = "github-actions-service-account"

  depends_on = [module.project_services]
}

resource "google_project_iam_member" "github_actions_service_account_roles" {
  project = local.config.project_id
  member  = "serviceAccount:${google_service_account.github_actions_service_account.email}"

  for_each = toset(local.config.github_actions_roles)
  role     = each.value
}
