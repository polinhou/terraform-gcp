resource "google_compute_firewall" "deny_ingress_firewall" {
  count = length(var.deny.ingress)

  name    = var.deny.ingress[count.index].name
  network = var.deny.ingress[count.index].network
  description = var.deny.ingress[count.index].description

  direction = "INGRESS"

  dynamic  "deny" {
    for_each = var.deny.ingress[count.index].target
    content {
      protocol = deny.key
      ports    = deny.value == "" ? [] : deny.value[*]
    }
  }

  source_tags = var.deny.ingress[count.index].source_tags

  source_ranges = var.deny.ingress[count.index].source_ranges

  target_tags = var.deny.ingress[count.index].target_tags

  priority = var.deny.ingress[count.index].priority == "" ? 1000 : var.deny.ingress[count.index].priority
}

resource "google_compute_firewall" "deny_egress_firewall" {
  count = length(var.deny.egress)

  name    = var.deny.egress[count.index].name
  network = var.deny.egress[count.index].network
  description = var.deny.egress[count.index].description

  direction = "EGRESS"

  dynamic  "deny" {
    for_each = var.deny.egress[count.index].target
    content {
      protocol = deny.key
      ports    = deny.value == "" ? [] : deny.value[*]
    }
  }

  destination_ranges = var.deny.egress[count.index].destination_ranges

  target_tags = var.deny.egress[count.index].target_tags

  priority = var.deny.egress[count.index].priority == "" ? 1000 : var.deny.egress[count.index].priority
}
