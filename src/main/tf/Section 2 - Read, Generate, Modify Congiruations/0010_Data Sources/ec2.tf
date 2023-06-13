// allow tf to read/use information defined outside of TF
// each provider offer data sources along side with resoucs types (may be data or may be a functon)

//local data souces ==> read from local system where tf runs
//others ==> read over newtowk when tf runs

provider "aws" {
  //region     = "eu-west-1" #London
  region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

data "aws_region" "current" {}

//resource "aws_instance" "app-west-1" {
//  ami = data.aws_ami.amiExample.id
//  instance_type = "t2.micro"
//}

resource "aws_instance" "app-west-2" {
  ami           = data.aws_ami.amiExample.id //region specific
  instance_type = "t2.micro"
}

//data blocking reading from amazon aws_ami info stores (reading from provider)
data "aws_ami" "amiExample" {
  most_recent = true //take the most recent image of a particular region
  owners      = ["amazon"]
  //  owners = ["self"] -- iams owned by the same AWS account ( so this is a AMI owned by the company which own the API. Ex : JPMC )
  filter { //after reading from amazon apply the filter
    name   = "name"
    values = ["amzn2-ami*"]
  }
}

output "aws_region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}

data "aws_ami_copy" "aws_ami_copy" {}
