# provider "vault" {
#   address = "https://<my-vault-hostname>:8200"
#   # token needs to be set via VAULT_TOKEN environment variable
#   # if using Vault namespaces set here via 'namespace' argument
# }

data "vault_aws_access_credentials" "creds" {
  backend = var.aws_secrets_engine_name
  role    = var.aws_secrets_engine_role
}