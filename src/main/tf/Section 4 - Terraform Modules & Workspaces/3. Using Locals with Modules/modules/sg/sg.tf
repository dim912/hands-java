resource "aws_security_group" "ec2-sg" {
  name        = "myec2-sg"
  ingress {
    description      = "Allow Inbound from Secret Application"
    from_port        = var.sec_port //this comes from the variables. And the module use can also override the value ( which is actually a risk ). so the solution is locals
    to_port          = local.app_port //this can not be overriden by the consumers of the module. So No risk. but still centrally controlled.
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-sg" {
  name        = "myelb-sg"
  ingress {
    description      = "Allow Inbound from Secret Application"
    from_port        = 8433
    to_port          = 8433
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

locals { //users of the modules can not override locals.
 app_port = 8333
}