terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "4.51.0"
   }
 }
}
provider "aws" {
  alias = "asia"
  region = "ap-southeast-1"
}

provider "aws" {
  alias = "emea"
  region = "eu-west-1"
}

locals {
  instance_type = "t2.micro"
  key_name = "dimu-imac"
}

//server with httpd installed
resource "aws_instance" "ec2_with_httpd_installed_server_asia_1" {
  provider = aws.asia
  ami = "ami-0753e0e42b20e96e3"
  instance_type = local.instance_type
  key_name = local.key_name
  vpc_security_group_ids = [aws_security_group.firewall_asia.id]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./dimu-imac-to-ap-southeast-1.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd.x86_64",
      "sudo systemctl start httpd.service",
      "sudo systemctl enable httpd.service",
      "sudo systemctl restart httpd.service",
      "sudo amazon-linux-extras install -y php7.2",
      "sudo chmod 777 /var/www/html"
    ]
  }
  provisioner "file" {
    content = "<?php echo gethostname(); ?>"
    destination = "/var/www/html/index.php"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo rm /var/www/html/index.html",
      "sudo systemctl restart httpd.service"
    ]
  }
}

resource "aws_security_group" "firewall_asia" {
  provider = aws.asia
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
}
resource "aws_ami_from_instance" "ec2_with_httpd_installed_server_ami_asia" {
  provider = aws.asia
  name               = "ami-with-httpd-installed"
  source_instance_id = aws_instance.ec2_with_httpd_installed_server_asia_1.id
}

resource "aws_instance" "ec2_with_httpd_installed_server_asia_2" {
  provider = aws.asia
 ami = aws_ami_from_instance.ec2_with_httpd_installed_server_ami_asia.id
 instance_type = local.instance_type
 vpc_security_group_ids = [aws_security_group.firewall_asia.id]
}

resource "aws_instance" "ec2_with_httpd_installed_server_asia_3" {
  provider = aws.asia
  availability_zone = "ap-southeast-1b"
  ami = aws_ami_from_instance.ec2_with_httpd_installed_server_ami_asia.id
  instance_type = local.instance_type
  vpc_security_group_ids = [aws_security_group.firewall_asia.id]
}

################## copy API cross region
resource "aws_security_group" "firewall_emea" {
  provider = aws.emea
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
}

resource "aws_ami_copy" "ec2_with_httpd_installed_server_ami_emea" {
  provider = aws.emea
  name              = "ec2_with_httpd_installed_server_ami_emea"
  source_ami_id     = aws_ami_from_instance.ec2_with_httpd_installed_server_ami_asia.id
  source_ami_region = "ap-southeast-1"
}

resource "aws_instance" "ec2_with_httpd_installed_server_emea_1" {
  provider = aws.emea
  ami = aws_ami_copy.ec2_with_httpd_installed_server_ami_emea.id
  instance_type = local.instance_type
  vpc_security_group_ids = [aws_security_group.firewall_emea.id]
}


output "ip_of_ec2_with_httpd_installed_server_asia_1" {
  value = aws_instance.ec2_with_httpd_installed_server_asia_1.public_ip
}

output "ip_of_ec2_with_httpd_installed_server_asia_2" {
  value = aws_instance.ec2_with_httpd_installed_server_asia_2.public_ip
}

output "ip_of_ec2_with_httpd_installed_server_asia_3" {
  value = aws_instance.ec2_with_httpd_installed_server_asia_3.public_ip
}


output "ip_of_ec2_with_httpd_installed_server_emea_1" {
  value = aws_instance.ec2_with_httpd_installed_server_emea_1.public_ip
}
