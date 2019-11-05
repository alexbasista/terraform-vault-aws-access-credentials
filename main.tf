data "vault_aws_access_credentials" "creds" {
  backend = var.aws_secrets_engine_name
  role    = var.aws_secrets_engine_role
  type    = "sts"
}