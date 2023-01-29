help:               ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

plan-quick:         ## terraform plan
	terraform plan -var config_file=sandbox.tfvars.yaml

plan-lock: init     ## Terraform plan -lock=false
	terraform plan -var config_file=sandbox.tfvars.yaml -lock=false

apply:              ## Terraform apply
	terraform apply -auto-approve -var config_file=sandbox.tfvars.yaml

apply-lock:         ## Terraform apply -lock=false
	terraform apply -auto-approve -var config_file=sandbox.tfvars.yaml -lock=false

init:               ## Terraform init
	terraform init -backend-config=vars/backend/sandbox.tfvars -upgrade

plan: init          ## Terraform plan
	terraform plan -var-file=vars/sandbox.tfvars -lock=false

refresh:            ## Terraform refresh
	terraform refresh -var config_file=sandbox.tfvars.yaml

state-ls:           ## Terraform state list
	terraform state list

fmt:                ## Execute terraform fmt
	terraform fmt --recursive .

validate: init      ## Terraform validate
	terraform validate

test: fmt init validate plan1
