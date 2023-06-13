
//s3 bucket should be pre created ( may be manually )

terraform {
  backend "s3" {
    bucket = "kplabs-terraform-backend"
    key    = "network/terraform.tfstate" //where the tfstate file will be stored
    region = "us-east-1"
  }
}

//S3 bitbucket can be kept as a access key, using "aws configure" cli

//remot backends are now legasy and TF recomands to use cloud
