# bootstrap

This is a simple Quickstart Repository for a working GCP organization and project structure with some stacks for different use cases. This is opinionated and will not cover all use cases or all things to think about but serves as a good starting point for getting your infrastructure up and running in a decent structure already. There are many things one can adjust depending on how a business operates, but that's not something I can put in a general bootstrap. This is aimed to be usable by many, but certainly, not everyone, at least not without modification.

You will find here:

- *config/* - terragrunt configurations - basically the variables
  - *components* - different reusable terragrunt components, that may or may not be used in multiple environments
  - *dev* - the development environment
  - *lz* - the landing zone
- *stacks/* - modules that expect some code completion magic to work from terragrunt, otherwise still flexible, but those are top level
- *modules/* - modules will be used in stacks sometimes. there are usually no modules-of-modules but modules-in-stacks only



NOTE: this is WiP, big changes will still happen

# TODO

- [ ] service accounts, permissions
- [ ] gh actions
- [ ] look at spacelift
- [ ] group permissions and mapping
- [ ] logging, monitoring, archive
- [ ] artifacts
- [ ] keys
- [ ] secret manager
- [ ] cloud run
- [ ] cloud sql
- [ ] memorystore
- [ ] vpc
- [ ] gke, lots details
- [ ] much what I likely forgot right now
