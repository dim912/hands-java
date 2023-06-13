// it is best to split large terraform project to small projects ( as ec2, lbs, eks ,SGs ...etc ). to make the API calls from the TF to aws smaller at a time.
//(state will be smaller)

//terraform plan -refresh=false    //usually tf connects to aws to refresh the status before plan/ or before apply. When -refresh=false, tf does not query the aws for curretn status
//(so it saves the bandwidth of tf to AWS cals)
//terraform plan -target=ec2  //refresh only ec2. nothing else
//terraform plan -target=aws_security_group.allow_ssh_conn  //so target refresh will happen only for aws_security_group.allow_ssh_conn

//anyway -refresh and -target are not recommended for production use

//some other info
// if "~" is seen under tf resource ==> that says there is an update going inplace( meaning by this plan)
// + => adding
// - => removing

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_ssh_conn" {
  name        = "allow_ssh_conn"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP into VPC"
    from_port   = 80
    to_port     = 80
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
  vpc_security_group_ids = [aws_security_group.allow_ssh_conn.id]
}
