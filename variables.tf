variable "resource_group_name" {
  description = "Name of the resource group that will contain the AKS cluster."
  type        = string
  default     = "cst8918-h09-rg"
}

variable "location" {
  description = "Azure region where the resources will be created."
  type        = string
  default     = "canadacentral"
}

variable "cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
  default     = "cst8918-h09-aks"
}

variable "dns_prefix" {
  description = "DNS prefix used when creating the AKS cluster's public FQDN."
  type        = string
  default     = "cst8918h09"
}

variable "vm_size" {
  description = "VM size used for the AKS default node pool."
  type        = string
  default     = "Standard_B2s_v2"
}

variable "min_node_count" {
  description = "Minimum number of nodes for the default node pool autoscaler."
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for the default node pool autoscaler."
  type        = number
  default     = 3
}
