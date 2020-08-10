resource "azurerm_resource_group" "demo" {
  name     = "${var.environment}-${var.app_name}-rg"
  location = var.region_primary
}

# resource "azurerm_container_registry" "demo-acr" {
#   name                = "grizzleacr27"
#   resource_group_name = azurerm_resource_group.demo.name
#   location            = azurerm_resource_group.demo.location
#   sku                 = "Premium"
#   admin_enabled       = true
# }

resource "azurerm_key_vault" "demo" {
  name                = "mastery-demo-grizzle"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "premium"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.client_id

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
    ]
  }
}