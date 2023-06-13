#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "web" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  count = 2   # says ==> create two of these resources. this avoid duplication. resouce runs in a loop
  tags = {
    name = "ec2_machine.${count.index}" #very instnace will have a uniqe name now ( since it refers the count.index)
  }
}

resource "aws_instance" "service_app" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  count = 3   # says ==> create two of these resources. this avoid duplication. resouce runs in a loop
  tags = {
    name = var.service_app_names[count.index]
  }
}

variable "service_app_names" {
  type = list(string)
  default = ["account-service","pay-service","login-service"]
}
