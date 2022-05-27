resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  mtu                             = var.mtu
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "vpc_subnet" {
  count         = length(var.subnet)
  name          = var.subnet[count.index].subnet_name
  ip_cidr_range = var.subnet[count.index].ip_cidr_range
  region        = var.subnet[count.index].region
  network       = google_compute_network.vpc_network.id
}
