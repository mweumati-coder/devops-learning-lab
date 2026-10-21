# 04 - Terraform basics (AWS)

Creates a secure S3 bucket (versioning, encryption, public access blocked, lifecycle rule). S3 costs almost nothing at this scale, which makes it a safe first project.

## What you will learn

- Providers, resources, variables, outputs
- Input validation
- `plan` before `apply`
- Default tags and naming conventions
- Remote state (exercise)

## Prerequisites

1. Install Terraform 1.5+.
2. Create an AWS account and an IAM user for learning (do not use the root account).
3. Configure credentials: `aws configure` or export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

## Run it

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy      # clean up when you are done
```

## Exercises

1. Change `environment` to `prod`, run `plan`, and read what Terraform wants to do. Replace or modify?
2. Set `environment = "test"` and read the validation error.
3. Create a separate state bucket and DynamoDB lock table by hand, then enable the `backend "s3"` block and run `terraform init -migrate-state`.
4. Add an `aws_s3_object` that uploads a small file.
5. Refactor the bucket into a reusable module under `modules/s3-bucket/` and call it twice.
6. Add a GitHub Actions job that runs `terraform fmt -check` and `terraform validate` on pull requests.
7. Run `tfsec` or `checkov` against this folder and read the findings.

## Warnings

- State files can contain secrets. They are git-ignored here; keep it that way.
- Always destroy practice resources.
