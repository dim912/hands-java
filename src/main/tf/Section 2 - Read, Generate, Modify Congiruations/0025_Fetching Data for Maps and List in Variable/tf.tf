provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

variable "iam_names" {
  type = list
  default = ["user-01","user-02","user-03"]  // so here resouce address will be aws_iam_user.iam[0], aws_iam_user.iam[1], aws_iam_user.iam[2]
}

resource "aws_iam_user" "iam" {
  name = var.iam_names[count.index]
  count = 3
  path = "/system/"
}

//let assume above is already applied to AWS

//lets say now "user-0" is added to the bigining of user list   ["user-0","user-01","user-02","user-03"]

//now when we run the script
    // TF sugest to add 1 => which is the user-0
    // modify already existing 3 (since now their indexs has to changes from 0->1 , 1->2, 2->3, 3->4)
// so this behaviour can mess up all the references  ( which refer the users by index )


//So TF sugguest,==>> only to use the count with resouces which are identical  (ex : same AMI, same instance_type)


//where then are differneces in resouces ( Ex: first ec2 is micro, second is medium, next is large ...etc  ) ==> use for_each

