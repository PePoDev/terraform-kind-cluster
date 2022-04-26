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
