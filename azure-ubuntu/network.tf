# create a virtual network
resource "azurerm_virtual_network" "ub-network" {
    name = "ubuntu-network"
    address_space = ["10.0.0.0/16"]
    location = "East US"
    resource_group_name = azurerm_resource_group.ub-rg.name
}

# create subnet
resource "azurerm_subnet" "ub-subnet" {
    name = "ubuntu-subnet"
    resource_group_name = azurerm_resource_group.ub-rg.name 
    virtual_network_name = azurerm_virtual_network.ub-network.name 
    address_prefixes = ["10.0.2.0/24"]
}

# create public IP
resource "azurerm_public_ip" "ub-ips" {
    name = "ubuntu-public-ip"
    location = "East US"
    resource_group_name = azurerm_resource_group.ub-rg.name 
    allocation_method = "Dynamic"
    tags = {
        environment = "ubuntu-a6"
    } 
}
