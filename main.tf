terraform {
  required_version = ">= 1.14.0"
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "b0ec999f-b48b-4499-8f02-dcd3bf1dbe7b"
}

# Resource Group 1
resource "azurerm_resource_group" "rg" {
  name     = "nrtest"
  location = "eastus"
}

# Resource Group 2
resource "azurerm_resource_group" "rg1" {
  name     = "amitest123"
  location = "eastus"
}

# Resource Group for VNet/Subnet
resource "azurerm_resource_group" "rg2" {
  name     = "network-rg"
  location = "eastus"
}

# Storage Account 1
resource "azurerm_storage_account" "sstss" {
  name                     = "amittestsa1232"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Storage Account 2
resource "azurerm_storage_account" "ssts1" {
  depends_on = [azurerm_resource_group.rg1]

  name                     = "amittestsa1233242"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Storage Account 3
resource "azurerm_storage_account" "stg1" {
  depends_on = [azurerm_resource_group.rg1]

  name                     = "amitstg1234445"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Additional Resource Group
resource "azurerm_resource_group" "rarf" {
  name     = "aDF"
  location = "Central India"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "amitest-vnet"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "amitestsubnet"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Additional Resource Group
resource "azurerm_resource_group" "arvi" {
  name     = "arvind1"
  location = "southindia"
}