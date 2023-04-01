variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-terraform-lab"
}
variable "location" {
  description = "Azure location"
  type        = string
  default     = "francecentral"
}
variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "vnet-terraform-lab"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "DEV"
}
variable "team" {
  description = "Team tag"
  type        = string
  default     = "DEVOPS"
}
