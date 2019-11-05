output "access_key" {
  value = vault_aws_access_credentials.creds.access_key
}

output "secret_key" {
  value = vault_aws_access_credentials.creds.secret_key
}

output "security_token" {
  value = vault_aws_access_credentials.creds.security_token
}