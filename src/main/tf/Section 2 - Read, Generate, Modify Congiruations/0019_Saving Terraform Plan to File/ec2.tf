
//this is to certain that only the changes shown in the plan are applied

//terraform plan -out=demopath ==> this generates a non human readable file (not a state file)
//terraform apply demopath  // now apply this

//this is neeeded beccuase --> terraform plan does not return the same result every time
// Ex: If the resources are changed in between in aws, then plan will result into different output
// Hence, it is possible to plan -out to a known location, and apply the changes to aws later with tf apply <output> ( even the current status at as is modified to something else by other users mean while)

provider "aws" {
  //region     = "eu-west-1" #London
  region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_instance" "myec2" {
  ami           = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
}
