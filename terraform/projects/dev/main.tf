module "foundation" {
  source = "../../templates/mlops-foundation"

  project_name    = var.project_name
  environment     = var.environment
  location        = var.location
  create_registry = var.create_registry
  tags            = var.tags
}
