# output "instance_id" {
#   value = aws_instance.ec2_instance.id
# }

# output "instance_public_ip" {
#   value = aws_instance.ec2_instance.public_ip
# }

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "tag_name" {
  value = aws_instance.ec2_instance.tags["Name"]
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "nginx_pod_name" {
  value = kubernetes_pod.nginx.metadata[0].name
}

output "nginx_pod_namespace" {
  value = kubernetes_pod.nginx.metadata[0].namespace
}

output "instance_state" {
  value = aws_instance.ec2_instance.instance_state
}

output "load_balancer_hostname" {
  value = kubernetes_service.nginx.status.0.load_balancer.0.ingress.0.hostname
}