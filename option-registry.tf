resource "docker_container" "registry" {
  count = var.enable_registry ? 1 : 0

  name    = "${var.cluster_name}-registry"
  image   = docker_image.registry[0].latest
  restart = "always"

  ports {
    internal = 5000

    ip       = "127.0.0.1"
    external = var.registry_port
  }

  networks_advanced {
    name = "kind"
  }
}

resource "docker_image" "registry" {
  count = var.enable_registry ? 1 : 0

  name = "registry:2"
}

resource "kubernetes_config_map" "local_registry_hosting" {
  metadata {
    name      = "local-registry-hosting"
    namespace = "kube-public"
  }

  data = {
    "localRegistryHosting.v1" = "host: \"localhost:${var.registry_port}\"\nhelp: \"https://kind.sigs.k8s.io/docs/user/local-registry/\"\n"
  }

  depends_on = [
    kind_cluster.this
  ]
}
