variable "resource_group_name_prefix" {
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default       = "rg"
}

variable "resource_group_location" {
  description   = "Location of the resource group."
  default       = "eastus"
}

variable "administrator_public_key" {
  description   = "Public Key of the Administrator SSH Key."
}