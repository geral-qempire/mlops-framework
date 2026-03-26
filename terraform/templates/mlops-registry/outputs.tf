output "resource_group_name" {
  description = "Name of the shared resource group"
  value       = module.resource_group.name
}

output "aml_registry_name" {
  description = "Name of the shared Azure ML registry"
  value       = module.aml_registry.name
}

output "aml_registry_id" {
  description = "ID of the shared Azure ML registry"
  value       = module.aml_registry.id
}
