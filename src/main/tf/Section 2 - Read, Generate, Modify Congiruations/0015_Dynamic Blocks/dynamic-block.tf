
//creating aws_instance using a set / map ( this does not need a dynamic block. )
//top level elemnts doe not need a dyndmic block

variable "serverNamesTest" {
  type    = list(string)
  default = ["serverOne", "serverTwo", "serverThree"]
}

resource "aws_instance" "myTestEc2" {
  for_each      = toset(var.serverNamesTest) /// this is the more enhanced version of count
  provider      = aws.asia
  ami           = lookup(local.ami_lookup, "asia")
  instance_type = "t1.micro"
  tags = {
    Name = each.value //each is a reference to the current element
  }
}


//for nested levels --> dynamic blocks are needed
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8300, 9200, 9500]
}

resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  dynamic "ingress" {       // KEYWORD DYNAMIC is used here
    for_each = var.sg_ports //looping happen here
    iterator = port         // this is optional. it only sets a variable to the current value of the iterator. this is only for readability
    content {
      from_port   = port.value //without iterator, port.value can be replaced with ingress.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


// multi level dynamic block

variable "load_balancer_origin_groups" {
  type = map(object({
    origins = set(object({
      hostname = string
    }))
  }))
}
resource "xxx" "name" {
  dynamic "origin_group" {
    for_each = var.load_balancer_origin_groups
    content {
      name = origin_group.key
      dynamic "origin" {
        for_each = origin_group.value.origins
        content {
          hostname = origin.value.hostname
        }
      }
    }
  }
}


