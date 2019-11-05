# terraform-vault-aws-access-credentials-sts
Terraform module to retrieve AWS access credentials from Vault via the AWS STS endpoint

## Requirements
- Terraform >= 0.12
- Vault instance with AWS Secrets Engine enabled with role configured with `assumed_role` credential type

## Usage
1. Enter the appropriate hostname for the Vault `address` provider arguement
2. Set a `VAULT_TOKEN` environment variable with priveleges to write against the Vault AWS Secrets backend

```hcl
provider "vault" {
  address = "https://<my-vault-hostname>:8200"
}

module "vault-aws-creds" {
  source = "github.com/alexbasista/terraform-vault-aws-access-credentials-sts"

  aws_secrets_engine_name = var.aws_secrets_engine_name
  aws_secrets_engine_role = var.aws_secrets_engine_role
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  token      = data.vault_aws_access_credentials.creds.security_token
  region     = "us-east-1"
}
```

## Inputs


## Outputs





