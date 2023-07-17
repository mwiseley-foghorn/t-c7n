## Track the State for this environment

terraform {
  backend "s3" {
    bucket         = "somebucket"
    key            = "dev.tf"
    region         = "us-east-1"
    dynamodb_table = "sometable"
  }
}

## Add calls to service modules required for this environment.

module ecommerce-site {
  environment = "development"
}
