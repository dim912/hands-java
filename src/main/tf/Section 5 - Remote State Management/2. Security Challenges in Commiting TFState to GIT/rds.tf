provider "aws" {
  region = "us-west-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}


resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = file("../rds_pass.txt") //password comes from a file outside of git.
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = "true"
}

//with this
// tf plan  -- shows no password -- good
// tf apply -- shows no password -- good
// But tfstate file --> shows the password -- so it is not a best practice to commit such tfstate files

// .gitignore
//.erraform
//terrafor.tfvars ( depends on env)
//terraform.tftsate ( should be stored remote. dont commit)
//crash.log