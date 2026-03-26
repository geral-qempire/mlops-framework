# TODO: Uncomment and configure once the Terraform state storage account is provisioned.
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "mlops-tfstate-rg"
#     storage_account_name = "mlopstfstatesa"
#     container_name       = "tfstate"
#     key                  = "shared.terraform.tfstate"
#   }
# }
