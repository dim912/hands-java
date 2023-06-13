
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-KEY-HERE"
  secret_key = "YOUR-KEY-HERE"
}

variable "instance_type_var" {
  default = "t2.micro"
}

//refer to the created module
module "ec2module" {
  source            = "../../modules/ec2"
  instance_type_var = "t2.large" //here we override the variable instance_type_var. so module which read from the var.instance_type_var will use this overided value to create the resouces
}


