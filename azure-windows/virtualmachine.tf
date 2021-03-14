# create virtual machine
resource "azurerm_virtual_machine" "win-vm" {
    name = var.vm_name
    location = var.region_fullname
    resource_group_name = azurerm_resource_group.win-rg.name 
    network_interface_ids = [azurerm_network_interface.win-nic.id] 
    vm_size = var.vm_size
    storage_image_reference { 
        publisher = "MicrosoftWindowsServer" 
        offer = var.vm_offer
        sku = var.vm_sku
        version = "latest"
    }
    storage_os_disk { 
        name = var.vm_osdisk_name
        vhd_uri = format("%s%s/%s%s", azurerm_storage_account.win-st.primary_blob_endpoint, azurerm_storage_container.win-st-cont.name, var.vm_osdisk_name, ".vhd")
        caching = "ReadWrite"
        create_option = "FromImage" 
    }
    os_profile {
        computer_name = var.vm_hostname
        admin_username = var.vm_username
        admin_password = var.vm_password
        custom_data = "${base64encode("Param($RemoteHostName = \"${null_resource.intermediates.triggers.full_vm_dns_name}\", $ComputerName = \"${var.vm_name}\", $WinRmPort = ${var.vm_winrm_port}) ${file("Deploy.PS1")}")}"
    }
    os_profile_windows_config { 
        provision_vm_agent = true
        enable_automatic_upgrades = true
        additional_unattend_config {
            pass = "oobeSystem" 
            component = "Microsoft-Windows-Shell-Setup"
            setting_name = "AutoLogon" 
            content = "<AutoLogon><Password><Value>${var.vm_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.vm_username}</Username></AutoLogon>"
        }
        additional_unattend_config {
            pass = "oobeSystem"
            component = "Microsoft-Windows-Shell-Setup"
            setting_name = "FirstLogonCommands"
            content = "${file("FirstLogonCommands.xml")}"
        }
    }

    provisioner "file" {
        source = "Test.PS1" 
        destination = "C:\\Scripts\\Test.PS1"
        connection {
            type = "winrm" 
            https = true
            insecure = true 
            user = var.vm_username
            password = var.vm_password
            host = "${null_resource.intermediates.triggers.full_vm_dns_name}" 
            port = "${var.vm_winrm_port}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "powershell.exe -sta -ExecutionPolicy Unrestricted -file C:\\Scripts\\Test.ps1",
        ]

        connection {
            type = "winrm"
            https = true
            insecure = true
            user = var.vm_username
            password = var.vm_password
            host = "${null_resource.intermediates.triggers.full_vm_dns_name}"
            port = "${var.vm_winrm_port}"
        }
    }

    tags = {
        environment = var.environment_name
    } 
}



