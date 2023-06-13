// constructs a map from list of keys and corresponding list of values

//keys = pineappel, orange, straberry
//color= yellow,orange,red
//zipmap ==> orange=organe, pineappel=yellow, straberry=red

//try below
//tf console
//zipmap(["pineapple","oranges","strawberry"], ["yellow","orange","red"])

provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}
resource "aws_iam_user" "lb" {
name = "demo-user.${count.index}"
count = 3
path = "/system/"
}

output "arns" {
value = aws_iam_user.lb[*].arn
}

output "zipmap" {
  value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}