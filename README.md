Given a DomainRoot, there is the need to configure a development project (subzone), and it's requisite independently addressible development lifecycle stages e.g. dev/test/stage/prod/ (sub-sub-zones) for the proper integration with AWS or Azure environments (handoffs to API gateways as an example).

I had hosted the DomainRoot in CloudFlare, however they did not, without a very expensive enterprise subscription, support cnamed sub-zones.  As such, it was decided to map the root into aws-route53 for the time being.

This project enables the building of a set of independently zoned sub-domains, and even nests to support CI/CD tooling.

This project make use of/requires Terraform, and uses the hashicorp/aws module to gain access to the aws-route53 facilities.

Further, this project defines the route as a "data" object instead of a "resource" so that terraform does not try and recreate the domainname which needs to be stable.
