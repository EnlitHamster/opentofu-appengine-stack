module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 17.1"

  project_id = local.config.project_id
  
  activate_apis = tolist(local.config.apis)
} 