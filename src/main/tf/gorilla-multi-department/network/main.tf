terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "4.51.0"
   }
 }
}

provider "aws" {
  alias = "asia"
  region = "ap-southeast-1"
}

provider "aws" {
  alias = "emea"
  region = "eu-west-1"
}

//ASIA

resource "aws_eip" "web_server_eip-asia" {
  provider = "aws.asia"
}
resource "aws_eip" "app_server_eip-asia" {
  provider = "aws.asia"
}

//EMEA
resource "aws_eip" "web_server_eip-emea" {
  provider = "aws.emea"
}
resource "aws_eip" "app_server_eip-emea" {
  provider = "aws.emea"
}
