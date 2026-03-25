output "id" {
  description = "ID of the Azure ML registry"
  value       = azapi_resource.this.id
}

output "name" {
  description = "Name of the Azure ML registry"
  value       = azapi_resource.this.name
}
