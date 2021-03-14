# create a virtual network
resource "azurerm_virtual_network" "ub-network" {
    name = var.network_name
    address_space = ["10.0.0.0/16"]
    location = var.region
    resource_group_name = azurerm_resource_group.ub-rg.name
}

# create subnet
resource "azurerm_subnet" "ub-subnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.ub-rg.name 
    virtual_network_name = azurerm_virtual_network.ub-network.name 
    address_prefixes = ["10.0.2.0/24"]
}

# create public IP
resource "azurerm_public_ip" "ub-ips" {
    name = var.public_ip_name
    location = var.region
    resource_group_name = azurerm_resource_group.ub-rg.name 
    allocation_method = "Dynamic"
    tags = {
        environment = var.environment_name
    } 
}

# create network interface
resource "azurerm_network_interface" "ub-nic" {
    name = var.network_interface_name
    location = var.region
    resource_group_name = azurerm_resource_group.ub-rg.name
    ip_configuration {
        name = "ubuntu-configuration"
        subnet_id = azurerm_subnet.ub-subnet.id 
        private_ip_address_allocation = "static"
        private_ip_address = "10.0.2.5"
        public_ip_address_id = azurerm_public_ip.ub-ips.id
    } 
}