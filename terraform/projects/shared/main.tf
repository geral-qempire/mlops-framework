module "registry" {
  source = "../../templates/mlops-registry"

  project_name = var.project_name
  location     = var.location
  tags         = var.tags
}
