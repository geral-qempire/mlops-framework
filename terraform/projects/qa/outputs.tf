output "resource_group_name" {
  value = module.workspace.resource_group_name
}

output "aml_workspace_name" {
  value = module.workspace.aml_workspace_name
}

output "aml_workspace_id" {
  value = module.workspace.aml_workspace_id
}

output "workspace_storage_account_name" {
  value = module.workspace.workspace_storage_account_name
}

output "datalake_storage_account_name" {
  value = module.workspace.datalake_storage_account_name
}

output "keyvault_name" {
  value = module.workspace.keyvault_name
}

output "container_registry_login_server" {
  value = module.workspace.container_registry_login_server
}
