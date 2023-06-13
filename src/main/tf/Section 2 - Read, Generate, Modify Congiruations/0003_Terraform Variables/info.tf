provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_vartest"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.hostIP]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.hostIP]
  }
}