variable "resource_group_name" {
  description = "Name for the resource group"
  default = "machine-rg"
}

variable "region" {
  description = "Region for the resources"
}

variable "network_name" {
  description = "Network name for the VM"
}

variable "subnet_name" {
  description = "Subnet name for the VM"
}

variable "public_ip_name" {
  description = "Public IP name for the VM"
}

variable "environment_name" {
  description = "Environment name for the VM"
}

variable "security_group_name" {
  description = "Security group name for the VM"
}

variable "network_interface_name" {
  description = "Network interface name for the VM"
}

variable "storage_account_name" {
  description = "Storage account name for the VM"
}

variable "storage_account_container" {
  description = "Storage account container for the VM"
}

variable "vm_name" {
  description = "Name for the VM"
}

variable "vm_size" {
  description = "Size for the VM"
}

variable "vm_offer" {
  description = "Offer for the VM"
}

variable "vm_sku" {
  description = "SKU for the VM"
}

variable "vm_osdisk_name" {
  description = "OS Disk Name for the VM"
}

variable "vm_hostname" {
  description = "Hostname for the VM"
}

variable "vm_username" {
  description = "Username for the VM"
}

variable "vm_password" {
  description = "Password for the VM"
}