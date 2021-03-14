# create storage account
resource "azurerm_storage_account" "ub-st" {
    name = "ubuntustorage125"
    resource_group_name = azurerm_resource_group.ub-rg.name 
    location = "eastus"
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = {
        environment = "ubuntu-a6" 
    }
}

# create storage container
resource "azurerm_storage_container" "ub-st-cont" {
    name = "ubuntustorage125-container"
    storage_account_name = azurerm_storage_account.ub-st.name 
    container_access_type = "private"
    depends_on = [azurerm_storage_account.ub-st]
}
