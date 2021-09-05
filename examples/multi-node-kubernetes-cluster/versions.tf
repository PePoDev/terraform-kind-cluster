terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.kind_cluster.endpoint
    client_certificate     = module.kind_cluster.client_certificate
    client_key             = module.kind_cluster.client_key
    cluster_ca_certificate = module.kind_cluster.cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = module.kind_cluster.endpoint
  client_certificate     = module.kind_cluster.client_certificate
  client_key             = module.kind_cluster.client_key
  cluster_ca_certificate = module.kind_cluster.cluster_ca_certificate
}
