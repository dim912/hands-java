//ASIA
output "allow_icmp_sg_id-asia" {
  //  value = aws_security_group.allow_icmp_sg //output can be even the whole object
  value = aws_security_group.allow_icmp_sg-asia.id
}

output "allow_ssh_sg_id-asia" {
  value = aws_security_group.allow_ssh_sg-asia.id
}

output "allow_allegress_sg_id-asia" {
  value = aws_security_group.allow_all_egress_sg-asia.id
}

//EMEA
output "allow_icmp_sg_id-emea" {
  value = aws_security_group.allow_icmp_sg-emea.id
}

output "allow_ssh_sg_id-emea" {
  value = aws_security_group.allow_ssh_sg-emea.id
}

output "allow_allegress_sg_id-emea" {
  value = aws_security_group.allow_all_egress_sg-emea.id
}

