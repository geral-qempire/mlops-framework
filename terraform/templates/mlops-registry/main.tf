locals {
  resource_prefix = "${var.project_name}-shared"

  common_tags = merge(var.tags, {
    environment = "shared"
    project     = var.project_name
    managed_by  = "terraform"
  })
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = "${local.resource_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "aml_registry" {
  source = "../../modules/aml-registry"

  name              = "${var.project_name}-registry"
  resource_group_id = module.resource_group.id
  location          = module.resource_group.location
  tags              = local.common_tags
}
