//export AWS_ACCESS_KEY_ID="anaccesskey"
//export AWS_SECRET_ACCESS_KEY="asecretkey"
terraform {
  required_version = ">= 0.11"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.51.0" //more than or equal to 4.51.0 but less than 4.52.0
    }
  }
}

data "terraform_remote_state" "network" {
  backend = "local"
  config ={
    path= "../network/terraform.tfstate.d/dev/terraform.tfstate"
  }
}


data "terraform_remote_state" "security" {
  backend = "local"
  config ={
    path= "../security/terraform.tfstate.d/dev/terraform.tfstate"
  }
}

data "aws_regions" "current" {}

provider "aws"  {
  region = "ap-southeast-1"
  alias = "asia"
}

provider "aws"  {
  region = "eu-west-1"
  alias = "emea"
}

###### ASIA

resource "aws_instance" "web_server-asia" {
  provider = aws.asia
  ami =  lookup(local.ami_lookup,"asia")
  instance_type = "t1.micro"
  key_name = "dimu-imac"
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.allow_icmp_sg_id-asia,
    data.terraform_remote_state.security.outputs.allow_ssh_sg_id-asia,
    data.terraform_remote_state.security.outputs.allow_allegress_sg_id-asia
  ]
  tags = {
    Name=  "${var.serverNames["web_server"]}-${terraform.workspace}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip //self if the parent
    private_key = file("../../dimu-imac-to-ap-southeast-1.pem")
  }

  provisioner "file" {
    source      = "./nginx-asia.conf"
    destination = "/tmp/nginx.conf"
  }

  provisioner "remote-exec" {
    inline= [
      "sudo cp /tmp/nginx.conf /etc/nginx/nginx.conf",
      "sudo nginx"
    ]
  }
}
resource "aws_eip_association" "web-server-eip-association-asia" {
  provider = aws.asia
  instance_id = aws_instance.web_server-asia.id
  allocation_id = data.terraform_remote_state.network.outputs.web_server_eip_id-asia
}

resource "aws_instance" "app_server-asia" {
  provider = aws.asia
  ami =  lookup(local.ami_lookup,"asia")
  instance_type = "t1.micro"
  key_name = "dimu-imac"
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.allow_icmp_sg_id-asia,
    data.terraform_remote_state.security.outputs.allow_ssh_sg_id-asia,
    data.terraform_remote_state.security.outputs.allow_allegress_sg_id-asia
  ]
  tags = { //if tags are added, then tf does not recreate the aws instance, instead it update the instance. if this tag is added manually directly on aws console => then tf plan will shows nothing to change
    Name=  "${var.serverNames["app_server"]}-${terraform.workspace}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip //self if the parent
    private_key = file("../../dimu-imac-to-ap-southeast-1.pem")
  }
  provisioner "remote-exec" {
    inline= ["sudo nginx"]
  }
}

resource "aws_eip_association" "app-server-eip-association-asia" {
  provider = aws.asia
  instance_id = aws_instance.app_server-asia.id
  allocation_id = data.terraform_remote_state.network.outputs.app_server_eip_id-asia
}

###### EMEA
resource "aws_instance" "web_server-emea" {
  provider = aws.emea
  ami =  lookup(local.ami_lookup,"emea")
  instance_type = "t1.micro"
  key_name = "dimu-imac"
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.allow_icmp_sg_id-emea,
    data.terraform_remote_state.security.outputs.allow_ssh_sg_id-emea,
    data.terraform_remote_state.security.outputs.allow_allegress_sg_id-emea
  ]
  tags = {
    Name=  "${var.serverNames["web_server"]}-${terraform.workspace}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip //self if the parent
    private_key = file("../../dimu-imac-to-eu-west-1.pem")
  }

  provisioner "file" {
    source      = "./nginx-emea.conf"
    destination = "/tmp/nginx.conf"
  }

  provisioner "remote-exec" {
    inline= [
      "sudo cp /tmp/nginx.conf /etc/nginx/nginx.conf",
      "sudo nginx"
    ]
  }
}

resource "aws_eip_association" "web-server-eip-association-emea" {
  provider = aws.emea
  allocation_id = data.terraform_remote_state.network.outputs.web_server_eip_id-emea
  instance_id = aws_instance.web_server-emea.id
}

resource "aws_instance" "app_server-emea" {
  provider = aws.emea
  ami =  lookup(local.ami_lookup,"emea")
  instance_type = "t1.micro"
  key_name = "dimu-imac"
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.allow_icmp_sg_id-emea,
    data.terraform_remote_state.security.outputs.allow_ssh_sg_id-emea,
    data.terraform_remote_state.security.outputs.allow_allegress_sg_id-emea
  ]
  tags = { //if tags are added, then tf does not recreate the aws instance, instead it update the instance. if this tag is added manually directly on aws console => then tf plan will shows nothing to change
    Name=  "${var.serverNames["app_server"]}-${terraform.workspace}"
  }
}

resource "aws_eip_association" "app-server-eip-association-emea" {
  provider = aws.emea
  allocation_id = data.terraform_remote_state.network.outputs.app_server_eip_id-emea
  instance_id = aws_instance.app_server-emea.id
}


module "ec2_from_module" {
  source = "../ec2/module"
  instanceName = "TestInsatnceName"
}