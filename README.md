# terraform-vault-aws-access-credentials-sts
Terraform module to retrieve AWS access credentials from Vault via the AWS STS endpoint

## Requirements
- Terraform >= 0.12
- Vault instance with AWS secrets engine enabled with role configured with `assumed_role` credential type

## Usage
1. Enter the appropriate hostname for the Vault `address` provider arguement
2. Set a `VAULT_TOKEN` environment variable with privileges to read against the Vault aws/sts/<aws-secrets-engine-role> endpoint

```hcl
provider "vault" {
  address = "https://<my-vault-hostname>:8200"
}

module "vault-aws-sts" {
  source = "github.com/alexbasista/terraform-vault-aws-access-credentials-sts"

  aws_secrets_engine_name = var.aws_secrets_engine_name
  aws_secrets_engine_role = var.aws_secrets_engine_role
}

provider "aws" {
  access_key = module.vault-aws-sts.access_key
  secret_key = module.vault-aws-sts.secret_key
  token      = module.vault-aws-sts.security_token
  region     = "<my-aws-region>"
}
```

## Inputs
| Variable | Type | Description | Default Value |
| -------- | ---- | ----------- | ------------- |
| aws_secrets_engine_name | string | Name of Vault AWS secrets engine mount where Vault role exists | |
| aws_secrets_engine_role | string | Name of Vault AWS role to retrieve creds from | |
| credentials_type | string | Type of credentials to retrieve from AWS secrets engine | sts |

## Outputs
| Name | Description |
| -------- | ---- |
| access_key | AWS Access Key ID returned from Vault |
| secret_key | AWS Secret Access Key returned from Vault |
| security_token | AWS STS Token (only returned when `credentials_type` is set to `sts`) |




