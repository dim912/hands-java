//------------------- COMMON ------------------------------------------------------
resource "aws_security_group" "firewall_asia_at_vpc_custom_vpc" {
  provider = aws.asia
  vpc_id = aws_vpc.custom_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8
    protocol  = "icmp"
    to_port   = 0
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
  egress{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol  = -1
    to_port   = 0
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8
    protocol  = "icmp"
    to_port   = 0
  }
}

//------------------- VPC ------------------------------------------------------

//one VPC spread spread accross multiple AZs
resource "aws_vpc" "custom_vpc" {
  provider = aws.asia
  cidr_block = "192.168.0.0/24"
  tags = {
    Name="Custom-VPC"
  }
}

// 3 subnets in AZ A and B (one public and two private)

// AZ - A
resource "aws_subnet" "az-a-private-1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.0/27"
  tags = {
    Name = "AZ-A-private-1"
  }
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "az-a-private-2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.32/27"
  tags = {
    Name = "AZ-A-private-2"
  }
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "az-a-public-1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.64/27"
  tags = {
    Name = "AZ-A-public-1"
  }
  availability_zone = "ap-southeast-1a"
}


// AZ - B
resource "aws_subnet" "az-b-private-1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.96/27"
  tags = {
    Name = "AZ-B-private-1"
  }
  availability_zone = "ap-southeast-1b"
}

resource "aws_subnet" "az-b-private-2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.128/27"
  tags = {
    Name = "AZ-B-private-2"
  }
  availability_zone = "ap-southeast-1b"
}

resource "aws_subnet" "az-b-public-1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "192.168.0.160/27"
  tags = {
    Name = "AZ-B-public-1"
  }
  availability_zone = "ap-southeast-1b"
}

// INSTANCES
resource "aws_instance" "in_custom_vpc_az-a-private-1" {
  key_name = local.key_name
  subnet_id = aws_subnet.az-a-private-1.id
  provider = aws.asia
  availability_zone = "ap-southeast-1a"
  ami = aws_ami_from_instance.ec2_with_httpd_installed_server_ami_asia.id
  instance_type = local.instance_type
  vpc_security_group_ids = [aws_security_group.firewall_asia_at_vpc_custom_vpc.id]
  tags = {
    Name = "in_custom_vpc_az-a-private-1"
  }
}

resource "aws_instance" "in_custom_vpc_az-a-public-1" {
  associate_public_ip_address = false
  key_name = local.key_name
  subnet_id = aws_subnet.az-a-public-1.id
  provider = aws.asia
  availability_zone = "ap-southeast-1a"
  ami = aws_ami_from_instance.ec2_with_httpd_installed_server_ami_asia.id
  instance_type = local.instance_type
  vpc_security_group_ids = [aws_security_group.firewall_asia_at_vpc_custom_vpc.id]
  tags = {
    Name="in_custom_vpc_az-a-public-1"
  }
  depends_on = [aws_internet_gateway.custom_vpc_igw]
}

// CONNECTING TO INTERNET

// IGW - public Subnets needs a IGW
resource "aws_internet_gateway" "custom_vpc_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "custom_vpc_IGW"
  }
}

//IGW - routing table with gw pointed to IGW
resource "aws_route_table" "public_routing_table" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_vpc_igw.id
  }
  tags = {
    Name = "public_routing_table"
  }
}

//attach routing table to public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.az-a-public-1.id
  route_table_id = aws_route_table.public_routing_table.id
}

//multiple ENIs from multiple subnets from same AZ can be attach to an instnace from same AZ
resource "aws_network_interface" "aws_network_interface_1" {
  subnet_id = aws_subnet.az-a-public-1.id
  security_groups = [aws_security_group.firewall_asia_at_vpc_custom_vpc.id]  //SECURITY GROUPS AT AT ENI LEVEL
}

resource "aws_eip" "eip_on_in_custom_vpc_az-a-public-1" {
//  network_interface = aws_network_interface.aws_network_interface_1.id
  instance = aws_instance.in_custom_vpc_az-a-public-1.id
}

resource "aws_network_interface" "aws_network_interface_2" {
  subnet_id = aws_subnet.az-a-private-2.id
}

// ENI from two subnets can be attached to a some EC2 ( but both subnets should be on same AZ)
//resource "aws_network_interface_attachment" "attach1" {
//  instance_id = aws_instance.in_custom_vpc_az-a-public-1.id
//  network_interface_id = aws_network_interface.aws_network_interface_1.id
//  device_index = 0
//}

//ACLs are stateless, applied at subnet level, by default allow both incoming and outgoing traffic

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.custom_vpc.id
  subnet_ids = []
  egress {
    protocol   = "-1"
    rule_no    = 200     //lower numbered rules get applied first
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 200     //lower numbered rules get applied first
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "custom NACL"
  }
}

//NAT - must have a EIP and must sits in a public subnet
resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "nat_gw_on_AZ_a" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.az-a-public-1.id
  tags = {
    Name ="nat_gw_on_AZ_a"
  }
}

//private subnet routing table should have a 0.0.0.0/0 entry to the nat GW
resource "aws_route_table" "routing_table_for_private_subnet_with_nat" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_on_AZ_a.id
  }
  tags = {
    Name = "private routing table"
  }
}

resource "aws_route_table_association" "route_table_association_with_nat" {
  route_table_id = aws_route_table.routing_table_for_private_subnet_with_nat.id
  subnet_id = aws_subnet.az-a-private-1.id
}



