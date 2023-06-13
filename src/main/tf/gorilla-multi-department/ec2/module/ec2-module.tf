resource "aws_instance" "ec2_from_modul" {
  ami = "ami-025468ad3c42e0236"
  instance_type = "t1.micro"
  tags = {
    Name=var.instanceName
  }
}

variable "instanceName" {

}