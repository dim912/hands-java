#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}
variable "name" {}
variable "default" {}

#keeping the commonly used values at a commn place
#over using --> makes the code less readable
locals {
  commonTags = {
    org = "DM2"
    name= "dimuthu"
  }
  #support expressions
  name_prefix = '${var.name!="" ? var.name : var.default}' #common expression
}

resource "aws_instance" "prod" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  tags = local.commonTags
  name = local.name_prefix
}

resource "aws_instance" "prod" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  tags = local.commonTags
}

