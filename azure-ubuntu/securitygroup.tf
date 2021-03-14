# create security group
resource "azurerm_network_security_group" "ub-sg" {
    name = var.security_group_name
    location = var.region
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