output "kube_config" {
  value = azurerm_kubernetes_cluster.app.kube_config_raw

  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.app.name
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.app.name
}
