# create security group
resource "azurerm_network_security_group" "ub-sg" {
    name = "ubuntu-sg"
    location = "eastus"
    resource_group_name = azurerm_resource_group.ub-rg.name
    security_rule {
        name = "SSH" 
        priority = 1001 
        direction = "Inbound" 
        access = "Allow" 
        protocol = "Tcp"
        source_port_range = "*" 
        destination_port_range = "22"
        source_address_prefix = "*" 
        destination_address_prefix = "*"
    }
    tags = {
        environment = "ubuntu-a6"
    }
}

# create network interface
resource "azurerm_network_interface" "ub-nic" {
    name = "ubuntu-nic"
    location = "East US"
    resource_group_name = azurerm_resource_group.ub-rg.name
    ip_configuration {
        name = "ubuntu-configuration"
        subnet_id = azurerm_subnet.ub-subnet.id 
        private_ip_address_allocation = "static"
        private_ip_address = "10.0.2.5"
        public_ip_address_id = azurerm_public_ip.ub-ips.id
    } 
}