provider "aws" {
  access_key                  = "mock_access_key"
  region                      = var.region
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    firehose       = "http://localhost:4573"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    route53        = "http://localhost:4580"
    redshift       = "http://localhost:4577"
    s3             = "http://localhost:4572"
    secretsmanager = "http://localhost:4584"
    ses            = "http://localhost:4579"
    sns            = "http://localhost:4575"
    sqs            = "http://localhost:4576"
    ssm            = "http://localhost:4583"
    stepfunctions  = "http://localhost:4585"
    sts            = "http://localhost:4592"
    ec2            = "http://localhost:4597"
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
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
