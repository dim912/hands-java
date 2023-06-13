
//simple S3 backend is not lock safe
//for to make the S3 bucket lock safe --> need to use dynamodb_table

terraform {
  backend "s3" {
    bucket = "kplabs-terraform-backend"
    key    = "network/demo.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking" // has to pre create a dynmo DB table. which has a partition as lockID.
  }
}


resource "time_sleep" "wait_150_seconds" {

  create_duration = "150s"
}