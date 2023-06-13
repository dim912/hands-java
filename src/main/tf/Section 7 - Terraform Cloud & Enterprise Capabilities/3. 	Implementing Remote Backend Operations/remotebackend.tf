/*

tf clould can be exeucted from the local machine of the dev  and stream the results into the devs machine console
all access keys/pwds comes from tf cloud

-- this needs a CLI-driven workflow

terraform login
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

remote backends does not support multipel souce file locaitons ( it has to be either on dev machine, or on the github or cloud. But not multiple)

*/

terraform {
  cloud { //recommanded to use built in clould backened insted of remotes
    organization = "mykplabs-org"
    workspaces {
      //name = "remote-operation"//limit only this workspace. so tf workspace select <otherws> does not work if this is applied
      tags = [ "my proejct tags"] //can swith to any workspace which has this tag . It is a must to have either name or tag
    }
  }
}
