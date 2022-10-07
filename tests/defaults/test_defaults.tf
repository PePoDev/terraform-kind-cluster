terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module "kind" {
  source = "../.."

  cluster_name       = "kind-cluster"
  kubernetes_version = "latest"
}

resource "test_assertions" "tests" {
  component = "kind"

  equal "cluster_name" {
    description = "Check the correct cluster name`"
    got         = module.kind.cluster_name
    want        = "kind-cluster"
  }

  check "kube_config" {
    description = "Can retrieve kubeconfig file"
    condition   = can(yamldecode(file(module.kind.kubeconfig_path)))
  }
}
