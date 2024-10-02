#!/bin/bash

# Ejecutar Terraform y guardar la salida
terraform -chdir=terrraform/ init
terraform -chdir=terrraform/ plan
terraform -chdir=terrraform/ apply -auto-approve 

# Verificar si Terraform se ejecutó exitosamente
if [ $? -eq 0 ]; then
  # Extraer el nombre de la instancia
  INSTANCE_NAME=$(terraform -chdir=terrraform/ output -raw tag_name)

  # Extraer la IP de la salida de Terraform
  INSTANCE_IP=$(terraform -chdir=terrraform/ output -raw instance_ip)

  # Crear el inventario dinámicamente
  echo "[$INSTANCE_NAME]" > ansible/inventory
  echo "$INSTANCE_IP ansible_ssh_private_key_file=../../devopsPin.pem ansible_user=ubuntu" >> ansible/inventory

if [ "$INSTANCE_STATE" == "running" ]; then
    # Si la instancia está en estado "running", proceder a ejecutar el playbook de Ansible
    ssh-keyscan -H $INSTANCE_IP >> ~/.ssh/known_hosts
   #     ansible-playbook -i ansible/inventory ansible/configure_vm.yml
  else
    echo "La instancia no está en estado 'running', su estado actual es: $INSTANCE_STATE. No se puede continuar."
  fi
else
  echo "Error: Terraform apply falló. No se puede continuar."
fi
