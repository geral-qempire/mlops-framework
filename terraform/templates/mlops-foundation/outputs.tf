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

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.name
}

output "keyvault_name" {
  description = "Name of the Key Vault"
  value       = module.keyvault.name
}

output "container_registry_login_server" {
  description = "Login server for the container registry"
  value       = module.container_registry.login_server
}

output "aml_registry_name" {
  description = "Name of the shared Azure ML registry (if created)"
  value       = var.create_registry ? module.aml_registry[0].name : null
}
