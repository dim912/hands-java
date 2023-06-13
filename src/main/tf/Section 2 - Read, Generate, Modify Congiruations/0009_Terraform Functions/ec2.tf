
# only support inbuilt functions
# does not support user defined functions

#terraform console, is one of ways to test functons

#ex functon
#max
#min
#element
#file -> reads a file as a string

provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}

variable "ami" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-0323c3dd2da7fb37d"
    "us-west-2"  = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0470e33cd681b2476"
  }
}

resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "app-dev" {
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.loginkey.key_name
  count         = 2

  tags = {
    Name = element(var.tags, count.index) //when index is more than the length of the array ==> then element function start counting again from first element 
  }
}

output "timestamp" {
  value = local.time
}
