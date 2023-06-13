
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-KEY-HERE"
  secret_key = "YOUR-KEY-HERE"
}

//refer to the created module
module "ec2module" {
  source = "../../modules/ec2"
}
