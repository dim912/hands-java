//

locals {
  db_password = {
    admin = "password"
  }
}

output "db_password" {
  value = local.db_password
  sensitive   = true //data is masked as <sensitive>
}