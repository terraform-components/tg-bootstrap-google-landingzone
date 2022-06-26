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

# remove all terragrunt caches. CAUTION.
clean-cache:
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;

log-settings:
	gcloud alpha logging settings update --organization=$(TF_VAR_org_id) --storage-location=europe-west3