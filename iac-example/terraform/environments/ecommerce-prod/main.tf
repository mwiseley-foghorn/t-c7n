## Track the State for this environment

terraform {
  backend "s3" {
    bucket         = "somebucketprod"
    key            = "production.tf"
    region         = "us-east-1"
    dynamodb_table = "sometableprod"
  }
}

## Add calls to service modules required for this environment.

module ecommerce-site {
  source      = "git@github.com/CompanyName/terraform-service-ecommerce-site?ref=v0.1.0"
  environment = "prod"
}
