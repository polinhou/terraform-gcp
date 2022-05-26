resource "google_compute_instance" "instance" {
  name  = "${var.instance_name}"
  machine_type = "${var.machine_type}"

  zone = "asia-east1-b"

  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_name}"
      size  = "10"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
