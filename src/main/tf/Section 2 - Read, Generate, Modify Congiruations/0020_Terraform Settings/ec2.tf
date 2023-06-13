
terraform { //terreform block here is used to configure the behavior of tf itself
  required_version = "> 0.11" // tf in local setup has to be more than 0.11
//  required_version = ">= 0.11" // tf in local setup has to be more than or equal 0.11
  required_providers {
    aws = "~> 2.0" //force teh provider versions. equal or greater than 2.0 but less than 2.1
  }
}

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

resource "aws_instance" "myec2" {
  ami = "ami-0b1e534a4ff9019e0"
  instance_type = "t2.micro"
}