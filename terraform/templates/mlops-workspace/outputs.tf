output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "aml_workspace_name" {
  description = "Name of the Azure ML workspace"
  value       = module.aml_workspace.name
}

output "aml_workspace_id" {
  description = "ID of the Azure ML workspace"
  value       = module.aml_workspace.id
}

output "workspace_storage_account_name" {
  description = "Name of the workspace storage account"
  value       = module.workspace_storage.name
}

output "datalake_storage_account_name" {
  description = "Name of the ADLS Gen2 data lake storage account"
  value       = module.datalake_storage.name
}

output "keyvault_name" {
  description = "Name of the Key Vault"
  value       = module.keyvault.name
}

output "container_registry_login_server" {
  description = "Login server for the container registry"
  value       = module.container_registry.login_server
}

