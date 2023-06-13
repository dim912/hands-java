//extract a specific value from the tf state file
//terraform output iam_names

provider "aws" {
  region     = "eu-west-2" #London
 // region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "myec2" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
}

output "outputIpOfMyEc2" {
  value = aws_instance.myec2.public_ip
}

//tf output outputIpOfMyEc2 -- this returns the IP of the myec2 ( fetch the state.
//other option is directly fetch from the state file )
