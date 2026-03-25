resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

locals {
  suffix          = random_string.suffix.result
  resource_prefix = "${var.project_name}-${var.environment}"
  # Storage account names must be lowercase alphanumeric, 3-24 chars
  storage_account_name = replace("${var.project_name}${var.environment}st${local.suffix}", "-", "")
  # Container registry names must be alphanumeric
  container_registry_name = replace("${var.project_name}${var.environment}acr${local.suffix}", "-", "")

  common_tags = merge(var.tags, {
    environment = var.environment
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

module "storage_account" {
  source = "../../modules/storage-account"

  name                = local.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.common_tags
}

module "keyvault" {
  source = "../../modules/keyvault"

  name                = "${local.resource_prefix}-kv-${local.suffix}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.common_tags
}

module "container_registry" {
  source = "../../modules/container-registry"

  name                = local.container_registry_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  log_analytics_name  = "${local.resource_prefix}-law"
  app_insights_name   = "${local.resource_prefix}-ai"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = local.common_tags
}

module "aml_workspace" {
  source = "../../modules/aml-workspace"

  name                    = "${local.resource_prefix}-ws"
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  application_insights_id = module.monitoring.app_insights_id
  key_vault_id            = module.keyvault.id
  storage_account_id      = module.storage_account.id
  container_registry_id   = module.container_registry.id
  tags                    = local.common_tags
}

module "aml_registry" {
  source = "../../modules/aml-registry"
  count  = var.create_registry ? 1 : 0

  name              = "${var.project_name}-registry"
  resource_group_id = module.resource_group.id
  location          = module.resource_group.location
  tags              = local.common_tags
}
