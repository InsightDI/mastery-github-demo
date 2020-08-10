resource "azurerm_storage_account" "demo" {
  name                      = "${var.environment}${var.app_name}stgacc"
  resource_group_name       = azurerm_resource_group.demo.name
  location                  = azurerm_resource_group.demo.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  tags                      = {}
  enable_https_traffic_only = "true"
}

resource "azurerm_advanced_threat_protection" "demo" {
  target_resource_id = azurerm_storage_account.demo.id
  enabled            = "true"
}

resource "azurerm_storage_container" "demo" {
  name                  = "${var.app_name}-blobs"
  storage_account_name  = azurerm_storage_account.demo.name
  container_access_type = "private"
}

# primary_access_key

resource "azurerm_key_vault_secret" "demo_storage_account_access_key" {
  name         = "demo-storage-account-access-key"
  value        = azurerm_storage_account.primary_access_key
  key_vault_id = azurerm_key_vault.demo.id
}

module "function_app_listener" {
  source                            = "./module/function-app"
  resource_group_name               = azurerm_resource_group.demo.name
  location                          = azurerm_resource_group.demo.location
  tags                              = {}
  storage_account_connection_string = azurerm_storage_account.demo.primary_connection_string
  function_app_name                 = "${var.environment}-${var.app_name}-Event-Hub-Listener"

  appsettings = {
    "AzureWebJobsStorage" : "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.demo.name};SecretName=${azurerm_key_vault_secret.demo_storage_account_access_key.name};SecretVersion=${azurerm_key_vault_secret.demo_storage_account_access_key.version})",
    "FUNCTIONS_WORKER_RUNTIME" : "dotnet",
    "devmasterysbusns_SERVICEBUS" : "Endpoint=sb://dev-mastery-sbus-ns.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=FtvYPwFpzHrzPEbjCxjkO0qfPgl+vcFmMiGrsGWKZmY="
    # "devmasterysbusns_SERVICEBUS": "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.demo.name};SecretName=${azurerm_key_vault_secret.demo_sbus_connection_string.name};SecretVersion=${azurerm_key_vault_secret.demo_sbus_connection_string.version})"
  }
}