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

