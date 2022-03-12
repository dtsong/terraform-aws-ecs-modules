# Terraform AWS ECS Modules

This repository contains various modules that can be utilized for running workloads on Amazon ECS utilizing Terraform (and/or Terragrunt if you wish).

**NOTE: Modules in this repository are mainly for my own Infrastructure as Code skill development and not quite battle-tested for real, production scenarios (at least not yet...). Use at your own risk.**

For more information on how to utilize each module, check the relevant module `README.md` files here:

### Table of Modules
  * [ecs](https://github.com/dtsong/terraform-ecs-modules/tree/master/lambda)
  * [iam/ecs](https://github.com/dtsong/terraform-aws-ecs-modules/tree/master/vpc)
  * [network](https://github.com/dtsong/terraform-aws-ecs-modules/tree/master/security_group)
  * [rds](https://github.com/dtsong/terraform-aws-ecs-modules/tree/master/secrets_manager)
  * [s3](https://github.com/dtsong/terraform-aws-ecs-modules/tree/master/rds)

## How do you use these modules with Terragrunt?

To use a module, create a  `terragrunt.hcl` file that specifies the module you want to use as well as values for the
input variables of that module:

```hcl
# Use Terragrunt to download the module code
terraform {
  source = "git::git@github.com:dtsong/terraform-aws-ecs-modules.git//path/to/module?ref=v0.0.1"
}

# Fill in the variables for that module
inputs = {
  name = "acme"
  
  wordle = 265
}
```

(*Note: the double slash (`//`) in the `source` URL is intentional and required. It's part of Terraform's Git syntax 
for [module sources](https://www.terraform.io/docs/modules/sources.html).*)

You then run [Terragrunt](https://github.com/gruntwork-io/terragrunt), and it will download the source code specified 
in the `source` URL into a temporary folder, copy your `terragrunt.hcl` file into that folder, and run your Terraform 
command in that folder: 

```
> terragrunt apply
[terragrunt] Reading Terragrunt config file at terragrunt.hcl
[terragrunt] Downloading Terraform configurations from git::git@github.com:dtsong/terraform-aws-serverless-modules.git//path/to/module?ref=v0.0.1
[terragrunt] Copying files from . into .terragrunt-cache
[terragrunt] Running command: terraform apply
[...]
```