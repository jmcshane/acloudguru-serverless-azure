resource "azurerm_cosmosdb_account" "db" {
  name                = "acloudgurumcshane"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  offer_type          = "Standard"
  kind                = "MongoDB"

  consistency_policy {
      consistency_level = "Session"
      max_interval_in_seconds = 5
      max_staleness_prefix = 100
  }
}

resource "azurerm_cosmosdb_mongo_database" "acg" {
  name                = "acloudguru"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  account_name        = "${azurerm_cosmosdb_account.db.name}"
}

resource "azurerm_cosmosdb_mongo_collection" "speakers" {
  name                = "speakers"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  account_name        = "${azurerm_cosmosdb_account.db.name}"
  database_name       = "${azurerm_cosmosdb_mongo_database.acg.name}"

  default_ttl_seconds = "0"
}

