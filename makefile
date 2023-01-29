help:               ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

init:               ## Terraform init
	terraform init -backend-config=vars/sandbox/backend.tfvars -upgrade

plan-quick:         ## terraform plan
	terraform plan -var-file=vars/sandbox/input.tfvars

plan: init          ## Terraform plan
	terraform plan -var-file=vars/sandbox/input.tfvars

apply:              ## Terraform apply
	terraform apply -auto-approve -var-file=vars/sandbox/input.tfvars

fmt:                ## Execute terraform fmt
	terraform fmt --recursive .

validate: init      ## Terraform validate
	terraform validate
