output "app_server_ip-asia" {
  value = aws_instance.app_server-asia.public_ip
}

output "web_server_ip-asia" {
  value = aws_instance.web_server-asia.public_ip
}

output "app_server_ip-emea" {
  value = aws_instance.app_server-emea.public_ip
}

output "web_server_ip-emea" {
  value = aws_instance.web_server-emea.public_ip
}
