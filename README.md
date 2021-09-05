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

| Name | Version |
|------|---------|
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~> 2.15 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | ~> 0.0.9 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.11 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 2.15.0 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.0.9 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.11.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.4.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kind_cluster.this](https://registry.terraform.io/providers/kyma-incubator/kind/latest/docs/resources/cluster) | resource |
| [kubectl_manifest.kubectl_apply_loadbalancer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kubectl_apply_metrics_server](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.loadbalancer_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.loadbalancer_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.loadbalancer_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [random_id.loadbalancer_secret_random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [docker_network.kind_network](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/data-sources/network) | data source |
| [kubectl_file_documents.loadbalancer_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.metrics_server_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name to create k8s cluster in Docker and set kubeconfig, You can use this cluster name select context with kubectl. | `string` | n/a | yes |
| <a name="input_containerd_config_patches"></a> [containerd\_config\_patches](#input\_containerd\_config\_patches) | Path config to existing default for containerd. | `list(string)` | `[]` | no |
| <a name="input_enable_loadbalancer"></a> [enable\_loadbalancer](#input\_enable\_loadbalancer) | Set to true to enable loadbalance for kind cluster. | `bool` | `false` | no |
| <a name="input_enable_metrics_server"></a> [enable\_metrics\_server](#input\_enable\_metrics\_server) | Set to true to install metrics server into cluster. | `bool` | `false` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specific kubernetes version to create cluster, Must specific in SemVer version. (Check all supported version -> https://hub.docker.com/r/kindest/node/tags) | `string` | `"1.21.1"` | no |
| <a name="input_node_image"></a> [node\_image](#input\_node\_image) | Change base image for kubernetes cluster, This parameter allow you to use local build image. | `string` | `"kindest/node"` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Nodes information to create cluster with control plan and worker. Default is AIO node. | <pre>list(object({<br>    role                   = string<br>    kubeadm_config_patches = list(string)<br>    extra_port_mappings = object({<br>      listen_address = string<br>      container_port = string<br>      host_port      = string<br>      protocol       = string<br>    })<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Client certificate content. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Client key content. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | CA Certificate content. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of cluster, Can be for kube context. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Cluster endpoint. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | Plaintext for kubeconfig generated for this kind cluster. |
| <a name="output_kubeconfig_path"></a> [kubeconfig\_path](#output\_kubeconfig\_path) | Path to kubeconfig file for this kind cluster that auto generated. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
