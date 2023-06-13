// module.<moduleName>.prop

module "sgmodule" {
  source = "../../modules/sg"
}

resource "aws_instance" "web" {
  ami           = "ami-0ca285d4c2cda3300"
  instance_type = "t3.micro"
  vpc_security_group_ids = [module.sgmodule.sg_id] //refer to the module and read the output of it into this module . Refering to the security group created in the module
}

output "sg_id_output" {
  value = module.sgmodule.sg_id
}