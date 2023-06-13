// Allows to have multiple workspaces
// ex:
//for staging     workspace => instance_type = t2.micro
//for development workspace => instance_type = t3.large

//terraform workspace show
//terraform workspace new prd
//terraform workspace list
//terraform workspace new dev
//terraform workspace -h
//terraform workspace select dev

//Terraform Based Configuration File

//each workspace will have a its own state file in clound
// tf workspace select <ws_name> works here with clould too

terraform {
  required_version = ">= 0.11"
  cloud {
    organization = "dimugorilla"
    workspaces {
      //name or tags are mandatory here
      tags = ["dimugorilla-tag"] //all newly creating worksapces have this tag. for already exising projects to connect, it must have this tag. 
      //name = "prod"   This limit only to have a single workspace as prod
    }
  }
}
