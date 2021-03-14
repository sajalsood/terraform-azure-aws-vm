# create a resource group
resource "azurerm_resource_group" "ub-rg" {
    name = "ubuntu-rg"
    location = "East US" 
}