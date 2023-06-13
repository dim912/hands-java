//lets assume the security project needs data from network project, which is used by another team
//so if the network team change the ip of eip, then tf apply should be done even at the security-project

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${data.terraform_remote_state.eip.outputs.eip_addr}/32"] //use the output from the network-project.
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}