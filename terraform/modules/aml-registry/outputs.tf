output "id" {
  description = "ID of the Azure ML registry"
  value       = azurerm_machine_learning_registry.this.id
}

output "name" {
  description = "Name of the Azure ML registry"
  value       = azurerm_machine_learning_registry.this.name
}
