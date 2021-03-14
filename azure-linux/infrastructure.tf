# Configure the Microsoft Azure Provider 
provider "azurerm" {
    features {} 
}

# create a resource group
resource "azurerm_resource_group" "ub-rg" {
    name = "ubuntu-rg"
    location = "East US" 
}

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

# create virtual machine
resource "azurerm_virtual_machine" "ub-vm" {
    name = "ubuntu-vm"
    location = "East US"
    resource_group_name = azurerm_resource_group.ub-rg.name 
    network_interface_ids = [azurerm_network_interface.ub-nic.id] 
    vm_size = "Standard_A0"
    storage_image_reference { 
        publisher = "Canonical" 
        offer = "UbuntuServer" 
        sku = "18.04.2-LTS" 
        version = "latest"
    }
    storage_os_disk { 
        name = "myosdisk" 
        vhd_uri = "azurerm_storage_account.ub-st.primary_blob_endpoint/azurerm_storage_container.ub-st-cont.name/myosdisk.vhd"
        caching = "ReadWrite"
        create_option = "FromImage" 
    }
    os_profile {
        computer_name = "hostname" 
        admin_username = "admin" 
        admin_password = var.vm-password
    }
    os_profile_linux_config { 
        disable_password_authentication = false
    }
    tags = {
        environment = "ubuntu-a6"
    } 
}


