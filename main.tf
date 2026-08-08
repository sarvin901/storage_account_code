terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "110285e0-ac2a-4940-b008-38ea221ac9a9"
}

resource "azurerm_resource_group" "rg" {
  name     = "noortest"
  location = "eastus"
}
resource "azurerm_resource_group" "rg1" {
  name     = "amitest"
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
  name                     = "amittestsa1234"
  resource_group_name      = "amitest1"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_account" "stg1" {
  name                     = "amitstg1"
  resource_group_name      = "amitest"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  
}
resource "azurerm_resource_group" "rg1" {
  count = length(var.rg_name)
  name     = var.rg_name[count.index]
  location = var.rg_location
}

resoucre "azurerm_storage_account" "stg1" {
  count = length(var.stg_name)
  name                     = var.stg_name[count.index]
  resource_group_name      = azurerm_resource_group.rg1[count.index].name
  location                 = azurerm_resource_group.rg1[count.index].location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  
}
resource azurerm_resource_group "rg1" {
  name = "aamit"
  location = "eastus"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "amivnet1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location

  address_space = ["10.0.0.0/16"]
}