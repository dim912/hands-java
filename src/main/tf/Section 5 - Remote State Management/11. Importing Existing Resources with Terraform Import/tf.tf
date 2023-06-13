// can the already pre existed manually created infra, be managed from terraform  ?????
// (lets assume aws infra already exit in the org and now company adopt tf )
// or to come out from a production incident, infra was manually created

//Documentation Referred:
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

//TF inport is to support this
      // resources tf files should be created manually (has to create this first)
      // this state file gets auto created.


//ec2_with_httpd_installed.tf
resource "aws_instance" "web" {  // manually look at the aws resources and create this file
  ami                    = "ami-098e42ae54c764c35"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0b784705b047aaf23"]
  key_name               = "terraform-key"
  tags = {
    Name = "terraform-ec2"
  }
}

//providers.tf
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

//Command To Import Resource
//terraform import aws_instance.web i-0f46ca5bb81b2c828  (map the resource to the running instance)  ==> this creates the state

//to verify if all good,
   // then run "tf plan" ==> and see if tf trying to do any chane ( if yes, then tf file should be manually modified to absorb the right status at the destination )


// current tf import  implementation ==> only import, but not the config files (so conf file shoudl be mannually written)
//in future tf import may generate config files too
