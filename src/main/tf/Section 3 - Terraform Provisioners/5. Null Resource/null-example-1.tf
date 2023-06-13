//null resource is not used much pracitcally

//it only establish lifecycle. But no resouces

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

resource "aws_eip" "lb" {
  vpc      = true
  depends_on = [null_resource.health_check] //says this eip will be created only if the null_resource created successfully
}

//lets assume that an EC2 should be created ==> Only if a known S3 bucket and a SFTP server is accessible.
//so before creating the EC2 server ==> has to check the connectivity. Hence use null_resource
//ex : take a file from FTP server and add into a S3 bucket
resource "null_resource" "health_check" {

  provisioner "local-exec" {

    command = "curl https://google.com"
  }
}