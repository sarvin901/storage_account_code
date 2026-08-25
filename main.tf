terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7d2b7ec8-30a6-4bc2-9251-5eb16f970054"
}

resource "azurerm_resource_group" "rg" {
  name     = "nrtest"
  location = "eastus"
}
resource "azurerm_resource_group" "rg1" {
  name     = "amitest123"
  location = "eastus"
}

resource "azurerm_storage_account" "sstss" {
  name                     = "amittestsa1232"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

resource "azurerm_storage_account" "ssts1" {
  depends_on               = [azurerm_resource_group.rg1]
  name                     = "amittestsa1233242"
  resource_group_name      = "amitest123"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_account" "stg1" {
  depends_on               = [azurerm_resource_group.rg1]
  name                     = "amitstg1234445"
  resource_group_name      = "amitest123"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

resource "azurerm_subnet" "subnet" {
  depends_on          = [azurerm_virtual_network.vnet, azurerm_resource_group.rg2]
  name                 = "amitestsubnet"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_resource_group" "arvi" {
  name = "arvind1"
  location = "south india"
  
}