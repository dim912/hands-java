
provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

resource "aws_eip" "lb" {
  vpc      = true
  count = 1
}

//clubing the provisioner from example-1
resource "null_resource" "ip_check" {

  triggers = { //soon as this output of the triggeres --> then re run the null_resource
    latest_ips = join(",", aws_eip.lb[*].public_ip)
  }

  provisioner "local-exec" {
    command = "echo Latest IPs are ${null_resource.ip_check.triggers.latest_ips} > sample.txt"
  }

}