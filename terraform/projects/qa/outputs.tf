output "resource_group_name" {
  value = module.foundation.resource_group_name
}

output "aml_workspace_name" {
  value = module.foundation.aml_workspace_name
}

output "aml_workspace_id" {
  value = module.foundation.aml_workspace_id
}

output "workspace_storage_account_name" {
  value = module.foundation.workspace_storage_account_name
}

output "datalake_storage_account_name" {
  value = module.foundation.datalake_storage_account_name
}

output "keyvault_name" {
  value = module.foundation.keyvault_name
}

output "container_registry_login_server" {
  value = module.foundation.container_registry_login_server
}

output "aml_registry_name" {
  value = module.foundation.aml_registry_name
}
