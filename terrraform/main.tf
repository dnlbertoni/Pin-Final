provider "aws" {
  region = "us-east-1"
}

data "aws_key_pair" "existing" {
  key_name = "devops"  
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.existing.key_name

  tags = {
    Name = "DevOps-Project"
  }
}

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}
