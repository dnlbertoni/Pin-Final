
variable "aws_region" {
  description = "La región de AWS donde se desplegará el clúster"
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "El AWS Access Key ID"
  type        = string
}

variable "aws_secret_key" {
  description = "El AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "El nombre del clúster EKS"
  default     = "eks-mundos-e"
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  default     = "10.0.0.0/16"
}

variable "node_group_desired_size" {
  description = "Tamaño deseado del grupo de nodos"
  default     = 2
}

variable "node_group_max_size" {
  description = "Tamaño máximo del grupo de nodos"
  default     = 3
}

variable "node_group_min_size" {
  description = "Tamaño mínimo del grupo de nodos"
  default     = 1
}

variable "node_group_instance_type" {
  description = "Tipo de instancia del grupo de nodos"
  default     = "t3.small"
}

variable "ec2_ami" {
  description = "AMI para la instancia EC2"
  default     = "ami-005fc0f236362e99f"  # Asegúrate de que esta AMI sea válida para tu región
}

variable "ec2_instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Nombre del par de claves EC2"
  default     = "devops"  # Asegúrate de que este key pair exista en tu cuenta de AWS
}

variable "ec2_name" {
  description = "Nombre de la instancia EC2"
  default     = "DevOps-Project"
}


variable "private_key_path" {
  description = "Ruta a la llave privada local para la conexión SSH"
  type        = string
}
