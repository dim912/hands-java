terraform {
  required_version = ">= 0.11"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.51.0" //more than or equal to 4.51.0 but less than 4.52.0
    }
  }
  cloud {
    organization = "dimugorilla"
    workspaces {
      tags =["dimugorilla-tag"]
      //tags = ["test","prod","dev"] limit operating on workspace which has these tags
      //name = "prod"   This limit only to have a single workspace as prod
    }
  }
}


provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "testintance" {
  ami="ami-025468ad3c42e0236"
  instance_type = "t1.micro"
}

