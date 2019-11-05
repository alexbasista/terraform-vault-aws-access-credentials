output "access_key" {
  sensitive = true
  value     = data.vault_aws_access_credentials.creds.access_key
}

output "secret_key" {
  sensitive = true
  value     = data.vault_aws_access_credentials.creds.secret_key
}

output "security_token" {
  sensitive = true
  value     = data.vault_aws_access_credentials.creds.security_token
}