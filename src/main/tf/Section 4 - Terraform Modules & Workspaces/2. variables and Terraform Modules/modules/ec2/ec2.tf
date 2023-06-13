resource "aws_instance" "myec2" {
  //instance_type = "t2.micro"  // heard coded values here can not be overriden from module. So use variables
  ami           = "ami-082b5a644766e0e6f" //no one can override. so controlled property of resouce
  instance_type = var.instance_type_var
}
