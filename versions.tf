terraform {
  required_providers {
    kind = {
      source  = "kyma-incubator/kind"
      version = "~> 0.0.9"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "kubectl" {
  config_path = "${var.cluster_name}-config"
}

provider "kubernetes" {
  config_path = "${var.cluster_name}-config"
}

provider "helm" {
  kubernetes {
    config_path = "${var.cluster_name}-config"
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
