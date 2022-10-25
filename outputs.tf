output "cluster_endpoint" {
  description = "Endpoint for CIVO Cluster"
  value = civo_kubernetes_cluster.my-cluster.api_endpoint
}

output "cluster_name" {
  description = "Cluster Name"
  value = civo_kubernetes_cluster.my-cluster.name
}

output "kubeconfig" {
  description = "Kube Config"
  sensitive =true 
  value = civo_kubernetes_cluster.my-cluster.kubeconfig
}

output "region" {
  description = "AWS region"
  value       = civo_kubernetes_cluster.my-cluster.region
}