resource "google_compute_firewall" "allow_ingress_firewall" {
  count = length(var.allow.ingress)

  name    = var.allow.ingress[count.index].name
  network = var.allow.ingress[count.index].network
  description = var.allow.ingress[count.index].description

  direction = "INGRESS"

  dynamic  "allow" {
    for_each = var.allow.ingress[count.index].target
    content {
      protocol = allow.key
      ports    = allow.value == "" ? [] : allow.value[*]
    }
  }

  source_tags = var.allow.ingress[count.index].source_tags

  source_ranges = var.allow.ingress[count.index].source_ranges

  target_tags = var.allow.ingress[count.index].target_tags

  priority = var.allow.ingress[count.index].priority == "" ? 1000 : var.allow.ingress[count.index].priority
}

resource "google_compute_firewall" "allow_egress_firewall" {
  count = length(var.allow.egress)

  name    = var.allow.egress[count.index].name
  network = var.allow.egress[count.index].network
  description = var.allow.egress[count.index].description

  direction = "EGRESS"

  dynamic  "allow" {
    for_each = var.allow.egress[count.index].target
    content {
      protocol = allow.key
      ports    = allow.value == "" ? [] : allow.value[*]
    }
  }

  destination_ranges = var.allow.egress[count.index].destination_ranges

  target_tags = var.allow.egress[count.index].target_tags

  priority = var.allow.egress[count.index].priority == "" ? 1000 : var.allow.egress[count.index].priority
}
