provider "aws" {
  access_key                  = "mock_access_key"
  region                      = var.region
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    es             = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    route53        = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
    ec2            = "http://localhost:4566"
  }
}

module "vpc" {
  source = "../../"

  name = var.vpc_name

  cidr = "10.120.0.0/16"

  azs                     = ["eu-west-1a", "eu-west-1c"]
  compute_public_subnets  = ["10.120.3.0/24", "10.120.4.0/24"]
  compute_private_subnets = ["10.120.0.0/24", "10.120.1.0/24"]
  lb_subnets              = ["10.120.5.0/24", "10.120.6.0/24"]
  database_subnets        = ["10.120.7.0/24", "10.120.8.0/24"]

  create_database_subnet_group = false
  enable_nat_gateway           = true
  single_nat_gateway           = true

  create_database_subnet_route_table = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

variable "vpc_name" {}
variable "region" {}
