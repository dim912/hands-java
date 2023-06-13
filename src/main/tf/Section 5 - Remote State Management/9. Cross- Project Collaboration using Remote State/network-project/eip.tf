//first create a eip and then output the publicIP of it

resource "aws_eip" "lb" {
  vpc      = true
}

output "eip_addr" {
  value = aws_eip.lb.public_ip
}