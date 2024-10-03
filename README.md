```
terraform -chdir=terrraform/ init
terraform -chdir=terrraform/ validate
terraform -chdir=terrraform/ plan -var-file=dev.tfvars -out=tfplan
terraform -chdir=terrraform/ apply tfplan
```
