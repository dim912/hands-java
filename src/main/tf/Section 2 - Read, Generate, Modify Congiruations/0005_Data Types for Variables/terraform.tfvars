#this file name must be terraform.tfvars
#if the file name is different
# the file name has be passed in command
# tf plan -var-file="custom.tfvars"

#string
instanceType = "t4g.micro"

az = ["es-west-1a", "us-west-1b"]
