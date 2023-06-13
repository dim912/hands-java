resource "aws_eip" "myeip" { //assume, needed in region1
  vpc = "true"
}


resource "aws_eip" "myeip01" { //assume, needed in region2
  vpc = "true"
  provider = "aws.aws02" //aws.<provider alias>
}