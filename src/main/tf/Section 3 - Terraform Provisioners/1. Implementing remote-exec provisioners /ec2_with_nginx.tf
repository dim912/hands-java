provider "aws" {
  //region     = "eu-west-1" #London
  region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "myec2" {
  ami = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
  key_name = "terraform-key" //key should be pre created
  //default security gruop is applied here ( which open port 22 in inbound and allow all outgoing traffic )

  connection {  // connect to EC2 from the local machine. Then this ssh connection will be used to execute the commands on the remote machine
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./terraform-key.pem") //keypair created on AWS -->
    host     = self.public_ip
  }

  provisioner "remote-exec" { //script is run on remote resouce after the resource is created.
    inline = [
      "sudo amazon-linux-extras install -y nginx1", //-y will do yes for prompt automatically.
      "sudo systemctl start nginx"
    ]
  }
}