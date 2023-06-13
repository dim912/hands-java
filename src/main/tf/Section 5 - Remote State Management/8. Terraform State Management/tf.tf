
//never modify the tfstate file manually
// use "tf state command"
// tf state list  ==> shows the resources within the statefile
// tf state move ==> to rename the exisitng recouse without destroy/create it (if the resouce is renamed in the tf tiles --> then it will destroy and re create the resouce)
//               ==> tf state move aws_instance.webapp aws_instance.myec2 ==> ( now tf plan will not show any thing to delete or add )
//               ==> tf state pull ( manually download the output of the state of remote location )
//               ==> tf state push ( manually upload a local state file to remote state) - rearely used
//               ==> tf state remove (remove items from tf. But here item is not removed from destination. But tf start not managing the resource any more). tf plan will not see the resouce anymroe
//               ==> tf state show <resouce_name>. list the properties of the resource from state file


provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
  ami           = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
}

terraform {
  backend "s3" {
    bucket     = "kplabs-remote-backends"
    key        = "demo.tfstate"
    region     = "us-east-1"
    access_key = "YOUR-ACCESS-KEY"
    secret_key = "YOUR-SECRET-KEY"
  }
}
