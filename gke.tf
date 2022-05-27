module "gke-cluster" {
  source       = "./modules/gke"

  cluster_name = "cluster"
  location     = "asia-east1"

  node_name    = "web"
  machine_type = "g1-small"

  node_count   = 1
}

