//ASIA
output "web_server_eip_id-asia" {
  value = aws_eip.web_server_eip-asia.id
}

output "app_server_eip_id-asia" {
  value = aws_eip.app_server_eip-asia.id
}

//EMEA
output "web_server_eip_id-emea" {
  value = aws_eip.web_server_eip-emea.id
}

output "app_server_eip_id-emea" {
  value = aws_eip.app_server_eip-emea.id
}

output "debug_printIps" {
  value = {
    web-sever-asia = aws_eip.web_server_eip-asia.public_ip
    app-sever-asia = aws_eip.app_server_eip-asia.public_ip
    web-sever-emea = aws_eip.web_server_eip-emea.public_ip
    app-sever-emea = aws_eip.app_server_eip-emea.public_ip
  }
}

