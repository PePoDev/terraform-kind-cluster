# Kind Cluster

Terraform module which creates Kubernetes Cluster resources on KIND (Kubernetes in Docker).

## Usage

### Basic Cluster Configuration

```hcl
module "kind_cluster" {
  source  = "pepodev/cluster/kind"
  version = "~> 0.1"

  cluster_name          = "kubernetes-problems"
  enable_metrics_server = true
  enable_loadbalancer   = true
}
```

## Examples

- [Simple Cluster](examples/simple-kubernetes-cluster)
- [Multiple Node Cluster](multi-node-kubernetes-cluster)
- [API Metrics Server](examples/metrics-api-server)
- [Nginx Ingress Controller](examples/nginx-ingress-controller)
- [Node Mount](examples/node-mount)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
