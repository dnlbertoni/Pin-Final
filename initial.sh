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

  # Esperar hasta que la instancia esté en estado "running"
  INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query "Reservations[*].Instances[*].InstanceId" --output text)
  
  while true; do
    STATUS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[*].Instances[*].State.Name" --output text)
    
    if [ "$STATUS" == "running" ]; then
      echo "La instancia está en estado 'running'."
      break
    else
      echo "Estado actual de la instancia: $STATUS. Esperando..."
      sleep 10  # Espera 10 segundos antes de volver a verificar
    fi
  done

  # Agregar la instancia a known_hosts
  ssh-keyscan -H $INSTANCE_IP >> ~/.ssh/known_hosts

  # Ejecutar el playbook de Ansible
  ansible-playbook -i ansible/inventory ansible/configure_vm.yml
else
  echo "Error: Terraform apply falló. No se puede continuar."
fi
