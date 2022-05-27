variable "instance_name" {}

variable "machine_type" {}

variable "zone" {}

variable "tags" {
  type = list
}

variable "image" {}

variable "size" {}

variable "network" {}

variable "subnetwork" {}

variable "preemptible" {
  default = false
}
