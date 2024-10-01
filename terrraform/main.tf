provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-005fc0f236362e99f"   # AMI de Ubuntu Server 22.04 en us-east-1
  instance_type = "t2.micro"
  key_name      = "pin"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y awscli docker.io jq
              curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
              chmod +x ./kubectl
              sudo mv ./kubectl /usr/local/bin/kubectl
              curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
              EOF
              
  tags = {
    Name = "DevOps-Project"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "devopsPin"
  public_key = file("/media/Containers/proyectos/devopsPin.pem")
}

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}