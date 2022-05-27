resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "random_id" "id" {
  byte_length = 4
  keepers = {
    name = var.node_name
  }
}

resource "google_container_node_pool" "node" {
  name       = "${var.node_name}-${random_id.id.hex}"
  location   = "asia-east1"
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

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


resource "null_resource" "get-kubectl-configure" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --region  ${google_container_cluster.cluster.location}"
  }
}
