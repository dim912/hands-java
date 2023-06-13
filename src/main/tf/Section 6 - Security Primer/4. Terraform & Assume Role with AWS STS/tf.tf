/*
what AWS recomands is,

having only one identity account which has access keys

and there are other accounts as , AWS(assume a role with a arn), Account1(), Account2()...

at operations, identity account assume roles

aws sts assume-role <arn> ==> this returns a AWS session token


*/

provider "aws" {
  region = "us-west-1"
  assume_role { //this gives the temporally credentials
   role_arn = "arn:aws:iam:223423wef"
    session_name = "demo"
  }
}

resource "aws_eip" "myepi" {
}

