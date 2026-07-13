resource "azurerm_resource_group" "app" {
  name     = var.resource_group_name
  location = var.location
}

# Look up the latest generally available Kubernetes version for the region
# so the cluster always builds with the newest supported release.
data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.app.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = var.cluster_name
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                = "default"
    vm_size             = var.vm_size
    enable_auto_scaling = true
    min_count           = var.min_node_count
    max_count           = var.max_node_count
  }

  identity {
    type = "SystemAssigned"
  }
}
