# terraform-vault-aws-access-credentials
Terraform module to retrieve AWS access credentials from Vault via the AWS secrets engine

## Requirements
- Terraform >= 0.12
- Vault instance/cluster with AWS secrets engine enabled and configured with Vault role

## Usage
There are two ways to consume this module depending on the credential type that was configured on the [Vault AWS role](https://www.vaultproject.io/docs/secrets/aws/index.html). The default usage is STS credentials, but IAM credentials are supported as well.

### STS credentials
1. Enter the appropriate hostname for the Vault `address` provider arguement
2. Set a `VAULT_TOKEN` environment variable with privileges to read against the Vault aws/sts/$aws_secrets_engine_role endpoint

```hcl
provider "vault" {
  address = "https://<my-vault-hostname>:8200"
}

module "vault-aws-sts" {
  source = "github.com/alexbasista/terraform-vault-aws-access-credentials"

  aws_secrets_engine_name = var.aws_secrets_engine_name
  aws_secrets_engine_role = var.aws_secrets_engine_role
}

provider "aws" {
  access_key = module.vault-aws-sts.access_key
  secret_key = module.vault-aws-sts.secret_key
  token      = module.vault-aws-sts.security_token
}
```

### IAM credentials
1. Enter the appropriate hostname for the Vault `address` provider arguement
2. Set a `VAULT_TOKEN` environment variable with privileges to read against the Vault aws/creds/$aws_secrets_engine_role endpoint
3. Specify `creds` for the `credential_type` argument (rather than the default `sts`)

```hcl
provider "vault" {
  address = "https://<my-vault-hostname>:8200"
}

module "vault-aws-creds" {
  source = "github.com/alexbasista/terraform-vault-aws-access-credentials"

  aws_secrets_engine_name = var.aws_secrets_engine_name
  aws_secrets_engine_role = var.aws_secrets_engine_role
  credential_type         = "creds"
}

provider "aws" {
  access_key = module.vault-aws-creds.access_key
  secret_key = module.vault-aws-creds.secret_key
}
```


## Inputs
| Name | Type | Description | Default Value |
| -------- | ---- | ----------- | ------------- |
| aws_secrets_engine_name | string | Name of Vault AWS secrets engine mount where Vault role exists | |
| aws_secrets_engine_role | string | Name of Vault AWS role to retrieve creds from | |
| credential_type | string | Type of credentials to retrieve from AWS secrets engine | sts |

## Outputs
| Name | Description |
| -------- | ---- |
| access_key | AWS Access Key ID returned from Vault |
| secret_key | AWS Secret Access Key returned from Vault |
| security_token | AWS STS Token (not returned when `credential_type` is set to `creds`) |




