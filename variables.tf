variable "aws_secrets_engine_name" {
  type        = string
  description = "Name of AWS Secrets Engine where role exists"
}

variable "aws_secrets_engine_role" {
  type        = string
  description = "Name of Vault role to retrieve creds from"
}

variable "credential_type" {
  type        = string
  description = "(Optional) Type of credentials to retrieve from Vault"
  default     = "sts"
}