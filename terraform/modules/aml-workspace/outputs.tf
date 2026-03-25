output "id" {
  description = "ID of the Azure ML workspace"
  value       = azurerm_machine_learning_workspace.this.id
}

output "name" {
  description = "Name of the Azure ML workspace"
  value       = azurerm_machine_learning_workspace.this.name
}

output "identity_principal_id" {
  description = "Principal ID of the workspace managed identity"
  value       = azurerm_machine_learning_workspace.this.identity[0].principal_id
}
