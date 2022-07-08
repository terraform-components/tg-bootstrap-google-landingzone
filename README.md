# landingzone bootstrap

project focusing on the landingzone aspects of a bootstrap

## initial bootstrap

the initial bootstrap has a bit of chicken egg, so we need to create and import a bit until its all fine.

```bash
# we need our environment variables set
direnv allow .

# login to your desired org
make login 

# for starting out we need an initial project. this will be the org management project
# this will contain the terraform state
export MANAGEMENT_PROJECT=tc-lz-management
gcloud projects create ${MANAGEMENT_PROJECT} --organization ${TF_VAR_org_id}
gcloud beta billing projects link ${MANAGEMENT_PROJECT} --billing-account ${TF_VAR_billing_account}

cd management

cd policies
terragrunt apply
# yes, we want to create the gcs bucket

cd ../policies
terragrunt apply
# yes, we want to create the gcs bucket

cd ../projects/lz
terragrunt import "google_project.project[\"lz-management\"]" ${MANAGEMENT_PROJECT}
terragrunt apply

# now we can continue normally
```
