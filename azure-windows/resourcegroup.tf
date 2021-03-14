# create a resource group
resource "azurerm_resource_group" "win-rg" {
    name = var.resource_group_name
    location = var.region_fullname
}