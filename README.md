# bootstrap

The goal of this repository is to give a simple quickstart of an opinionated secure and flexible structure for your GCP organization and projects, that should give you at minimum a good starting point, but will even be good enough for many early projects while giving the flexibility of future changes. For achieving this I have made many choices to keep things simple but also flexible in a lego-manner, so you can mix and match to what your needs are. While this is a starting point it is by no means the best way to do it or will apply to any scale or complexity. The bigger or more complex your project, the more considerations you will have and the more time and effort you should put into that.

You will find here:

- *config/* - terragrunt configurations - basically the variables and those are using the stacks
  - *components* - different reusable terragrunt components, that may or may not be used in multiple environments
  - *dev* - the development environment
  - *lz* - the landing zone
- *stacks/* - modules that expect some code completion magic to work from terragrunt, otherwise still flexible, but those are top level
  - *tfstate* - creating it on gcp. bit of a chicken-egg, hence also top level for simplicity, but could be changed
  - *org-policies* - some basic policies you may want to set
  - *github-workload-pool* - setup for CI
  - *folders* - create the necessary folder structure on gcp
  - *projects* - creating projects in those folders with certain apis activated. this may be used more than once per environment
  - *service-accounts-lz* - service accounts for landingzone. they are quite a bit different than for other environments
  - *service-accounts-infra* - infrastructure deployer and viewer service accounts for environments
  - *artifacts-registry*
  - *network*
  - *network-subnets*
  - *network-nat*
  - *network-gke*
  - *kms*
  - *gke*
  - *cloudrun*
  - *service-account-app*
  - *loadbalancer-l7-global*
- *modules/* - modules will be used in stacks sometimes. there are usually no modules-of-modules but modules-in-stacks only


NOTE: this is WiP early stage, big changes will still happen
