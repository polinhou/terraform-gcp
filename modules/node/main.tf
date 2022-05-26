resource "random_id" "id" {
  byte_length = 4
  keepers = {
    machine_type = var.machine_type
  }
}

resource "google_container_node_pool" "node" {
  name       = "${var.name}-${random_id.id.hex}"
  location   = "asia-east1"
  cluster    = var.cluster
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = "web"
    }

    tags = ["web"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}
