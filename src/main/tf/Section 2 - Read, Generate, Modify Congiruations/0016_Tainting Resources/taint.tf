//terraform taint aws_instance.myec2

// Ex : assume there are lot other chanegs that are manually down outside of TF
// there are two was to cater this now
// 1) import the changes to tf
// 2) delete all resources are recreate
       // using taint comamnd a tf created resouce can be marked as tained. then recosuce will be deleted and recreated in next apply from scretch
       // tf taint aws_instance.myec22. // this marks the aws_instance.myec22 to as tainted in the state file
       // tf plan ( shows 1 to add and 1 to destroy. because the aws instance is marked for deletion since it is tainted)
       // tf apply ( will delete and create the resouces )

// tainting resouce for recration may affect on depending resouces. Ex: if EC2 is deleted/created ==> then DNS resouces may  be recreated with the new IP of the ec2

provider "aws" {
  //region     = "eu-west-1" #London
  region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "myec22" {
  ami = "ami-005835d578c62050d"
  instance_type = "t2.micro"
}