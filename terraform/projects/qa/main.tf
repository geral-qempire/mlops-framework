module "workspace" {
  source = "../../templates/mlops-workspace"

  project_name = var.project_name
  environment  = var.environment
  location     = var.location
  tags         = var.tags
}
