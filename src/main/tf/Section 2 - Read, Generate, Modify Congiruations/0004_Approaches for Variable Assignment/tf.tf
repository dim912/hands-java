
#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "web" {
  ami = "ami-018542fa4c710a021"
  instance_type = var.instanceType
  tags = {
    name: "HelloWorld"
  }
}