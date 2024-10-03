# EC2 Instance con llave SSH y script de instalación
resource "aws_instance" "ec2_instance" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name  
  subnet_id              = aws_subnet.eks_subnet[0].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Script de instalación ejecutado automáticamente al iniciar la instancia
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io kubectl helm
              sudo systemctl enable docker
              sudo systemctl start docker
            EOF

  tags = {
    Name = var.ec2_name
  }

  # Provisioner para copiar un script de restauración usando SSH basado en llave
  provisioner "file" {
    source      = "scripts/restore.sh"
    destination = "/tmp/restore.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Usuario predeterminado de Ubuntu en AWS AMIs
      private_key = file(var.private_key_path)  # Ruta a tu llave privada
      host        = self.public_ip
    }
  }

  # Provisioner para ejecutar el archivo de instalación usando SSH basado en llave
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "sudo apt install dos2unix -y",
      "dos2unix /tmp/install.sh",
      "sudo bash /tmp/install.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Usuario predeterminado de Ubuntu en AWS AMIs
      private_key = file(var.private_key_path)  # Ruta a tu llave privada
      host        = self.public_ip
    }
  }
}
