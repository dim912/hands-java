#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_eip" "lb" {
  vpc = true
}

output "eipDetails" {
  value = aws_eip.lb
}

#accessible properties are listed in provider documentation under attibutes
#same can be seen in tfstate file values
#when the resouces is printe it prints all possible output values of the resource
output "eipIP" {
  value = aws_eip.lb.public_ip
}

