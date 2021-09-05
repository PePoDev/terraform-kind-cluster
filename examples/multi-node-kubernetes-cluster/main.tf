module "kind_cluster" {
  source = "../../"

  cluster_name          = "kubernetes-problems"
  enable_metrics_server = true
  enable_loadbalancer   = false

  nodes = [
    {
      role                   = "control-plan"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    },
    {
      role                   = "control-plan"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    },
    {
      role                   = "control-plan"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    },
    {
      role                   = "worker"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    },
    {
      role                   = "worker"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    },
    {
      role                   = "worker"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    }
  ]
}
