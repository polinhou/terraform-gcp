resource "google_compute_instance" "instance" {
  name          = var.instance_name
  machine_type  = var.machine_type

  zone          = var.zone

  tags          = var.tags

  boot_disk {
    initialize_params {
      image     = var.image
      size      = var.size
    }
  }

  network_interface {
    network     = var.network
    subnetwork  = var.subnetwork
  }

  scheduling {
    preemptible = var.preemptible
  }
}
