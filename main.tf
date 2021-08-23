#
# Domain Setup
#
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.48.0"
    }
  }
}

provider "aws" {
  //profile = "default"
  region = var.aws_region

  default_tags {
   tags = {
     Name       = "Test"
     Origin     = "terraform"
     Workspace  = "${terraform.workspace}"
   }
 }
}

/*resource "aws_acm_certificate" "function" {
  domain_name       = local.project_domain_name
  //domain_name = var.domain_name
  validation_method = "DNS"
}*/

locals {
  records = {
    for name in var.domains :
        name => regex("^(?P<host>[^\\.]+)\\.(?P<domain>.+)$", name)
  }
}

# Public root zone
//terraform import 'aws_route53_zone.apex' xZ013059723DYIUSHH86MW
data "aws_route53_zone" "apex" {
  name = var.domain_name
  //zone_id = "Z013059723DYIUSHH86MW"
}

resource "aws_route53_zone" "proj_domain" {
  for_each = var.domains
  name = each.value
}

resource "aws_route53_record" "proj_ns" {
  for_each = var.domains 
  zone_id = data.aws_route53_zone.apex.zone_id
  name    = each.value
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.proj_domain[each.value].name_servers
}



