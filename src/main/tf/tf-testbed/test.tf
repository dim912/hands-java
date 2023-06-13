
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.52.0"
    },
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }
  }
}
provider "aws" {
  # Configuration options
}

variable "without_type" {}

variable "testVar" {
  type    = string
  default = 2
}


locals {
  source = "test"
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

output "source" {
  value = local.source
}
