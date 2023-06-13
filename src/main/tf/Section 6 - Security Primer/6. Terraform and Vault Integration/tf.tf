//Hashicorp vault allow companies to save passwords, certificates etc in a vault, ( db password, encription keys)
//there is a cli and a UI given by Hashicorp for vault

//support generating key/secrets which are valid only for 24 horus (lease duration can be even 1h)
//then developer can use this

//provider to connect to vault
provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "demo" { //reads the secret from vault
  path = "secret/db_creds"
}

output "vault_secrets" {
  value = data.vault_generic_secret.demo.data_json  //this will be a part of tf state file ( as plain text )
  sensitive = "true"
}