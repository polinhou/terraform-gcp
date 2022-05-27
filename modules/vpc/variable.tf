variable "vpc_name" {}

variable "auto_create_subnetworks" {
  default = "false"
}

variable "mtu" {
  default = "1460"
}

variable "delete_default_routes_on_create" {
  default = false
}

variable "subnet" {}
