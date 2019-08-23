resource "azurerm_resource_group" "rg" {
    name     = "acloudguru-serverless-course"
    location = "centralus"
}

resource "azurerm_eventgrid_topic" "test" {
  name                = "acg-eg-jamesmcshane"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_storage_account" "acg_storage" {
    name                        = "acgjamesmcshane"
    resource_group_name         = "${azurerm_resource_group.rg.name}"
    location                    = "${azurerm_resource_group.rg.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"
    account_kind                = "StorageV2"
    access_tier                 = "Hot"
    enable_https_traffic_only   = true
}

resource "azurerm_storage_container" "web" {
  name                  = "$web"
  storage_account_name  = "${azurerm_storage_account.acg_storage.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "images" {
  name                  = "images"
  storage_account_name  = "${azurerm_storage_account.acg_storage.name}"
  container_access_type = "private"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "CentralUSPlan"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  kind                = "functionapp"
  reserved            = false

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
