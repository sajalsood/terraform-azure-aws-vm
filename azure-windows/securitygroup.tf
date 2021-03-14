# create security group
resource "azurerm_network_security_group" "win-sg" {
    name = var.security_group_name
    location = var.region_fullname
    resource_group_name = azurerm_resource_group.win-rg.name
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

resource "azurerm_network_security_rule" "win-rdp-rule" {
    name = var.rdp_rule_name
    priority = 100 
    direction = "Inbound" 
    access = "Allow" 
    protocol = "Tcp"
    source_port_range = "*" 
    destination_port_range = "3389"
    source_address_prefix = "*" 
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.win-rg.name 
    network_security_group_name = azurerm_network_security_group.win-sg.name
}

resource "azurerm_network_security_rule" "win-rm-rule" {
    name = var.rm_rule_name
    priority = 110
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = var.vm_winrm_port
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.win-rg.name
    network_security_group_name = azurerm_network_security_group.win-sg.name
}
