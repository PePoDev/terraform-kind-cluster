terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.14"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }
  }
}

resource "time_sleep" "wait_cluster" {
  create_duration = "10s"
  depends_on      = [kind_cluster.this]
}

data "local_file" "kube_config" {
  filename   = "${var.cluster_name}-config"
  depends_on = [time_sleep.wait_cluster]
}

provider "kubectl" {
  config_path = data.local_file.kube_config.filename
}

provider "kubernetes" {
  config_path = data.local_file.kube_config.filename
}

provider "helm" {
  kubernetes {
    config_path = data.local_file.kube_config.filename
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
