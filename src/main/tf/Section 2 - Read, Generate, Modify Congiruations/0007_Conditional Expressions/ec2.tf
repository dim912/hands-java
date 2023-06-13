#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

variable "isTest" {
  type = bool
}

resource "aws_instance" "test" {
  ami           = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  tags = {
    name : "HelloWorld"
  }
  count = var.isTest == true ? 1 : 0 // so count can be used here to control if the resouce shoudl be created or not
}

resource "aws_instance" "prod" {
  ami           = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  tags = {
    name : "HelloWorld"
  }
  count = var.isTest == false ? 1 : 0
}

