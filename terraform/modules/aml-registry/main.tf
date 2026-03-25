resource "azurerm_machine_learning_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }

  storage_account {
    storage_account_id = var.storage_account_id
  }

  tags = var.tags
}
