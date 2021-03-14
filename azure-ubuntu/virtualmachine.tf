# create virtual machine
resource "azurerm_virtual_machine" "ub-vm" {
    name = "ubuntu-vm"
    location = "East US"
    resource_group_name = azurerm_resource_group.ub-rg.name 
    network_interface_ids = [azurerm_network_interface.ub-nic.id] 
    vm_size = "Standard_B1ls"
    storage_image_reference { 
        publisher = "Canonical" 
        offer = "UbuntuServer" 
        sku = "18.04-LTS" 
        version = "latest"
    }
    storage_os_disk { 
        name = "myosdisk" 
        vhd_uri = format("%s%s/%s", azurerm_storage_account.ub-st.primary_blob_endpoint, azurerm_storage_container.ub-st-cont.name, "myosdisk.vhd")
        caching = "ReadWrite"
        create_option = "FromImage" 
    }
    os_profile {
        computer_name = "hostname" 
        admin_username = "ubuntu" 
        admin_password = var.vm-password
    }
    os_profile_linux_config { 
        disable_password_authentication = false
    }
    tags = {
        environment = "ubuntu-a6"
    } 
}