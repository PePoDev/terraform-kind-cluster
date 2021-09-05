resource "kubectl_manifest" "kubectl_apply_metrics_server" {
  count     = var.enable_metrics_server ? length(data.kubectl_file_documents.metrics_server_manifests[0].documents) : 0
  yaml_body = element(data.kubectl_file_documents.metrics_server_manifests[0].documents, count.index)
}

data "kubectl_file_documents" "metrics_server_manifests" {
  count   = var.enable_metrics_server ? 1 : 0
  content = file("${path.module}/kubernetes/metrics-server.yml")
}
