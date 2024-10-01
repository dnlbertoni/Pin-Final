#!/bin/bash

terraform -chdir=terrraform/ apply -auto-approve | tee terraform_output.txt

# Extraer la IP de la salida de Terraform
INSTANCE_IP=$(grep -oP '(?<=instance_ip = ).*' terrraform/terraform_output.txt)

# Crear el inventario dinámicamente
echo "$INSTANCE_IP ansible_ssh_private_key_file=../../devopsPin.pem ansible_user=ubuntu" >> ansible/inventory

# Ejecutar el playbook de Ansible
#ansible-playbook configure_vm.yml 
