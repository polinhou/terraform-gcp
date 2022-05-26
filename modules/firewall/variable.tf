variable "network" {}

variable "allow" {
  default = {
    ingress = []
    egress  = []
  }
}

variable "deny" {
  default = {
    ingress = []
    egress  = []
  }
}
