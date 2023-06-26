help:               ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

init:               ## Terraform init
	terraform init -backend-config=vars/sbx/backend.tfvars -upgrade

plan-quick:         ## terraform plan
	terraform plan -var-file=vars/sbx/input.tfvars

plan: init          ## Terraform plan
	terraform plan -var-file=vars/sbx/input.tfvars

apply:              ## Terraform apply
	terraform apply -auto-approve -var-file=vars/sbx/input.tfvars

fmt:                ## Execute terraform fmt
	terraform fmt --recursive .

validate: init      ## Terraform validate
	terraform validate
