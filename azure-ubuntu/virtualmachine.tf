# create virtual machine
resource "azurerm_virtual_machine" "ub-vm" {
    name = var.vm_name
    location = var.region
    resource_group_name = azurerm_resource_group.ub-rg.name 
    network_interface_ids = [azurerm_network_interface.ub-nic.id] 
    vm_size = var.vm_size
    storage_image_reference { 
        publisher = "Canonical" 
        offer = var.vm_offer
        sku = var.vm_sku
        version = "latest"
    }
    storage_os_disk { 
        name = var.vm_osdisk_name
        vhd_uri = format("%s%s/%s%s", azurerm_storage_account.ub-st.primary_blob_endpoint, azurerm_storage_container.ub-st-cont.name, var.vm_osdisk_name, ".vhd")
        caching = "ReadWrite"
        create_option = "FromImage" 
    }
    os_profile {
        computer_name = var.vm_hostname
        admin_username = var.vm_username
        admin_password = var.vm_password
    }
    os_profile_linux_config { 
        disable_password_authentication = false
    }
    tags = {
        environment = var.environment_name
    } 
}