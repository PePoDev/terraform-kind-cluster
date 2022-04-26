resource "kubernetes_namespace" "loadbalancer_namespace" {
  count = var.enable_loadbalancer ? 1 : 0
  metadata {
    name = "metallb-system"
    labels = {
      "app" = "metallb"
    }
  }

  depends_on = [
    kind_cluster.this
  ]
}

resource "random_id" "loadbalancer_secret_random" {
  count       = var.enable_loadbalancer ? 1 : 0
  byte_length = 128
}

resource "kubernetes_secret" "loadbalancer_secret" {
  count = var.enable_loadbalancer ? 1 : 0
  metadata {
    name      = "memberlist"
    namespace = kubernetes_namespace.loadbalancer_namespace[0].id
  }
  data = {
    secretkey = random_id.loadbalancer_secret_random[0].b64_std
  }
}

data "docker_network" "kind_network" {
  count = var.enable_loadbalancer ? 1 : 0
  name  = "kind"
}

resource "kubernetes_config_map" "loadbalancer_config" {
  count = var.enable_loadbalancer ? 1 : 0
  metadata {
    name      = "config"
    namespace = kubernetes_namespace.loadbalancer_namespace[0].id
  }

  data = {
    config = <<-EOF
      address-pools:
      - name: default
        protocol: layer2
        addresses:
        - 172.${split(".", tolist(data.docker_network.kind_network[0].ipam_config).0.gateway)[1]}.255.250-172.${split(".", tolist(data.docker_network.kind_network[0].ipam_config).0.gateway)[1]}.255.250
    EOF
  }
}

resource "kubectl_manifest" "kubectl_apply_loadbalancer" {
  count     = var.enable_loadbalancer ? length(data.kubectl_file_documents.loadbalancer_manifests[0].documents) : 0
  yaml_body = element(data.kubectl_file_documents.loadbalancer_manifests[0].documents, count.index)
}

data "kubectl_file_documents" "loadbalancer_manifests" {
  count   = var.enable_loadbalancer ? 1 : 0
  content = file("${path.module}/manifest/loadbalancer.yml")
}
