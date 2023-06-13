provider "aws" {
  //region     = "eu-west-1" #London
  region     = "ap-southeast-1" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}

resource "aws_iam_user" "lb" {
  name  = "iamuser.${count.index}"
  count = 3 //0,1,2
  path  = "/system/"
}

output "arnsof0" {
  value = aws_iam_user.lb[0].arn //only for 0
}

output "arns" {
  value = aws_iam_user.lb[*].arn //for each iam user
}


locals {
  tmpList = toset([
    {
      name = "dimuthu"
      age  = 32
    },
    {
      name = "sanduni"
      age  = 31
    }
  ])
}


//splat expression  == works only with lists and sets .( NOT with MAPS )
output "with_splat_expression" {
  value = local.tmpList[*].name
}

//for loop (for MAPS MUST use a FOR expression)
output "with_for_loop" {
  value = [for e in local.tmpList : e.name]
}


//Splat expressions have a special behavior when you apply them to a value that isn't a list, set, or tuple.

variable "website_setting" {
  type = object({
    index_document = string
    error_document = string
  })
  default = null
}

output "splat_on_objects" {
  value = var.website_setting[*]
}
