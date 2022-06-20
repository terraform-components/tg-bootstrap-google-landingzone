plan-all:
	terragrunt run-all plan --terragrunt-log-level=error -lock=false --terragrunt-non-interactive

apply-all:
	terragrunt run-all apply

format: 
	terragrunt hclfmt
	terraform fmt -recursive -diff -write=true

#####

login:
	gcloud auth login
	gcloud auth application-default login

docker-configure:
  # https://cloud.google.com/artifact-registry/docs/docker/authentication#gcloud-helper
	gcloud auth configure-docker europe-docker.pkg.dev
	