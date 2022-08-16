terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.0"
        }
    }
}
provider "aws" {
    alias = "awscloud"
    default_tags {
        tags = {
            createdby = "ajithrajs@presidio.com"
            purpose = "devopstraining"
            environment = var.appenvironment == "dev" ? "development" : "production"
        }
    }
    region = "us-east-1"
}
# module "altoze" {
#     source = "./infra"
#     # providers = {
#     #   aws = aws.awscloud
#     # }
# }