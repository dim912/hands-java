/*

TF cloud manage tf runs in a consistent & reliable env with features like access control, private registery for sharing modules, policy control etc

Ex : forcing versions of tf to be used in the org
maintain modules
policy check


workspace (has to create and manually and linked to github or any other repo)
aws key/secret are added as env variables in as workspace

when code is commited to github --> tf cloud automatically start planning

when tf workspace is destroyed --> the resources are also destroyed in aws

*/



/*
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
*/

provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "myec2" {
  ami = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
}