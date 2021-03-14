# create a virtual network
resource "azurerm_virtual_network" "win-network" {
    name = var.network_name
    address_space = ["10.0.0.0/16"]
    location = var.region_fullname
    resource_group_name = azurerm_resource_group.win-rg.name
}

# create subnet
resource "azurerm_subnet" "win-subnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.win-rg.name 
    virtual_network_name = azurerm_virtual_network.win-network.name 
    address_prefixes = ["10.0.1.0/24"]
}

# create public IP
resource "azurerm_public_ip" "win-ips" {
    name = var.public_ip_name
    location = var.region_fullname
    resource_group_name = azurerm_resource_group.win-rg.name 
    allocation_method = "Dynamic"
    domain_name_label = var.domain_name_label
    tags = {
        environment = var.environment_name
    } 
}

# create network interface
resource "azurerm_network_interface" "win-nic" {
    name = var.network_interface_name
    location = var.region_fullname
    resource_group_name = azurerm_resource_group.win-rg.name
    ip_configuration {
        name = "windows-configuration"
        subnet_id = azurerm_subnet.win-subnet.id 
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.win-ips.id
    } 
    tags = {
        environment = var.environment_name
    } 
}
