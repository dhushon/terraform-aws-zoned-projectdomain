variable "aws_region" {
    type        = string
    default     = "us-east-1"
    description = "primary AWS region"
}

variable "domain_name" {
    type = string
    description = "FQDN for environment"
}

variable "domains" {
  type = set(string)
  default = [
    "droopy.demostrator.com",
    "sneezy.demostrator.com",
    "doc.demonstrator.com",
    "happy.demonstrator.com"
  ]
  description = "fully qualified subdomain names"
}

variable "stages" {
  type = set(string) 
  default = ["dev","test","demo","stage","prod"]
  description = "Development lifecycle stages to pre-stage"
}