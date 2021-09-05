resource "kind_cluster" "this" {
  name            = var.cluster_name
  node_image      = "${var.node_image}:v${var.kubernetes_version}"
  wait_for_ready  = true
  kubeconfig_path = null

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = var.nodes
      content {
        role = node.value["role"]
        # TODO: add support for more node option [https://github.com/kyma-incubator/terraform-provider-kind/blob/83d5502462e9ec33d4fa26c41a3ccf80d6cee0f4/kind/schema_kind_config.go#L76]
        # image = null
        # extra_mounts {
        #   host_path      = null
        #   container_path = null
        # }
        dynamic "extra_port_mappings" {
          for_each = node.value["extra_port_mappings"] == null ? [] : [node.value["extra_port_mappings"]]
          content {
            listen_address = extra_port_mappings.value["listen_address"]
            container_port = extra_port_mappings.value["container_port"]
            host_port      = extra_port_mappings.value["host_port"]
            protocol       = extra_port_mappings.value["protocol"]
          }
        }

        kubeadm_config_patches = node.value["kubeadm_config_patches"]
      }
    }

    # TODO: Add support networking option [https://github.com/kyma-incubator/terraform-provider-kind/blob/83d5502462e9ec33d4fa26c41a3ccf80d6cee0f4/kind/schema_kind_config.go#L31]
    # networking {
    #   ip_family           = null
    #   api_server_address  = null
    #   api_server_port     = null
    #   pod_subnet          = null
    #   service_subnet      = null
    #   disable_default_cni = null
    #   kube_proxy_mode     = null
    # }

    containerd_config_patches = var.containerd_config_patches
    # TODO: Example patch
    # containerd_config_patches = [
    #         <<-TOML
    #         [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
    #             endpoint = ["http://kind-registry:5000"]
    #         TOML
    #     ]
  }
}
