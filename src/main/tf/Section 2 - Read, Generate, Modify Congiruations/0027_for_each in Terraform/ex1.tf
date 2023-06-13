//use map or a set as index value for the created resouce

provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

resource "aws_iam_user" "iam" {
  for_each = toset( ["user-01","user-02", "user-03"] ) // so there the resouce address will be ==> aws_iam_user.iam[user-01], aws_iam_user.iam[user-02]. this is better than list  when adding new elements.
  name     = each.key
}
//so there the resouces address will be ==> aws_iam_user.iam[user-01], aws_iam_user.iam[user-02]. this is better than list  when adding new elements.
//so with set name is the index of the resouce (not the 0,1,...2  as list)
