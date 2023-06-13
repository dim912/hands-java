terraform {
  required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "4.51.0"
   }
  }
}
provider "aws" {
  region = "ap-southeast-1"
  alias = "asia"
}

provider "aws" {
  region = "eu-west-1"
  alias = "emea"
}

locals {
  com_igress = toset([
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = -1
      protocol  = "icmp"
      to_port   = -1
    } ,
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 80
      protocol  = "tcp"
      to_port   = 80
    }
    ]
  )
}

//ASIA
resource "aws_security_group" "allow_icmp_sg-asia" {
  provider = aws.asia
  tags = {
    Name = "allow_icmp_sg-asia1"
  }
  dynamic ingress  {
    for_each = local.com_igress
   //  iterator = entry  //iterator can be used to increase the readability. otherwise, the object can be access though ingress here
    //if iterator is assigned then ignress does not hold the iterator
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port = ingress.value.from_port
      protocol =  ingress.value.protocol
      to_port= ingress.value.to_port
    }
  }
}

resource "aws_security_group" "allow_ssh_sg-asia" {
  provider = aws.asia
  tags = {
    Name = "allow_ssh_sg-asia"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
}

resource "aws_security_group" "allow_all_egress_sg-asia" {
  provider = aws.asia
  tags = {
    Name = "allow_all_egress_sg-asia"
  }
  egress{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol  = 0
    to_port   = -1
  }
}

/// EMEA
resource "aws_security_group" "allow_icmp_sg-emea" {
  provider = aws.emea
  tags = {
    Name = "allow_icmp_sg-emea"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = -1
    protocol  = "icmp"
    to_port   = -1
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
}

resource "aws_security_group" "allow_ssh_sg-emea" {
  provider = aws.emea
  tags = {
    Name = "allow_ssh_sg-emea"
  }
 ingress {
   cidr_blocks = ["0.0.0.0/0"]
   from_port = 22
   protocol  = "tcp"
   to_port   = 22
 }
}

resource "aws_security_group" "allow_all_egress_sg-emea" {
  provider = aws.emea
  tags = {
    Name = "allow_all_egress_sg-emea"
  }
  egress{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol  = 0
    to_port   = -1
  }
}

locals {
  tmpList = toset([
    {
      name="dimuthu"
      age=32
    },
    {
      name="sanduni"
      age=31
    }
  ])
}

output "with_for_loop" {
  value = [for e in local.tmpList : e.name]
}

output "with_splat_expression" {
  value = local.tmpList[*].name
}


