# create storage account
resource "azurerm_storage_account" "ub-st" {
    name = var.storage_account_name
    resource_group_name = azurerm_resource_group.ub-rg.name 
    location = var.region
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = {
        environment = var.environment_name
    }
}

# create storage container
resource "azurerm_storage_container" "ub-st-cont" {
    name = var.storage_account_container
    storage_account_name = azurerm_storage_account.ub-st.name 
    container_access_type = "private"
    depends_on = [azurerm_storage_account.ub-st]
}
