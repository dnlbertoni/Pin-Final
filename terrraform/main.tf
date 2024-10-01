provider "aws" {
  region = "us-east-1"
}

data "aws_key_pair" "existing" {
  key_name = "devops"  # Cambia a tu key pair existente
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-005fc0f236362e99f"  # AMI de Ubuntu Server 22.04 en us-east-1
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.existing.key_name

  user_data = file("../scripts/initialInstance.sh")  # Cambia a la ruta correcta del script

  tags = {
    Name = "DevOps-Project"
  }
}

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}
