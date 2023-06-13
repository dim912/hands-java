
//1) creation time provisioner
//if creation time provisioner fails --> then resource is marked as tainted.
//because provisioner can run in the next iteration ( deployment )
//2) destroy time provisioner

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myec2" {
  ami                    = "ami-0b1e534a4ff9019e0"
  instance_type          = "t2.micro"
  key_name               = "ec2-key"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nano" // default type => creation time provisioner
    ]
  }
  provisioner "remote-exec" {
    when = destroy // get called just before destroy
    inline = [
      "sudo yum -y remove nano" //ex this might be needed to handle the licence of the anti virus software( if the max number of machines for anti-virus is limited)
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./ec2-key.pem")
    host        = self.public_ip
  }
}
