#hashcorp maintained providers
provider "aws" {
  region     = "eu-west-2" #London
  access_key = "access_key_val"
  secret_key = "secret_key_val"
}
provider "azurerm" {
  # Configuration options
}

#mandatory for non hash-corp maintained (for 0.13+ version of TF)
terraform {
  required_providers {  # provider has to be inside required_providers block
    digitalocean = {
      source = "digitalocean/digitalocean" #what is seen in url
      version = "2.24.0"
    }
  }
}

resource "aws_instance" "web" {
  ami = "ami-018542fa4c710a021"
  instance_type = "t4g.micro"
  tags = {
    name: "HelloWorld"
  }
}

# tf init
    # download the plugins associated with provider
# tf plan
# tf apply
    # with this, tf fetch the current state of the actual infra and compare with the desired state
# tf destroy
# tf refresh --> refresh the tfstate file reading the actual infra setup

# selectively destroy
# tf destroy -target aws_instance.web  (resource type + local resouce name)
# if resource is moved out from the tf file --> then resouce gets deleted


# tf state file
# -------------

#tf locally store the state of resouces in the state file
#tf store even properties like ip address/volume etc

# with tf delete --> the resouces will be deleted even from state file
# so state file is a representation of the actual resouces
# state does not impacted by the plan operation. But only get modified when apply

#if tfstate file is delted --> tf has no way to know what resouces are create
#so tf will try to create all resouces from bigging


# Desired state and current state
# ---------------------------------

#desired state = tf file
#current state = might not be mapping to desired state since some one could have manuplated resouces in aws

# tf plan shows the difference between current vs desired

#configs does not rever the changes which are not explianed in the desired state
      # Ex: if EC2 is created without mentioning the security group
      # if manually security group is changed on aws console
      # tf plan will not detect it as a change since, security group is not definedd in the desired state
      # hence best is -> Defining all possible parameters in terraform

#Provider versioning

# terraform version and provider plugin version are two different things

# if provider plugin version is not mentioned
         # tf download the latest version of the plugin
         # but this could cuase to problems, if tf version changes
         # hence best is specifying the provider version specifically

# version = "~> 3.6" any version is 3.x range --> so tf will download the latest in 3.x range

#.terraform.lock.hcl
  # ==> shows the exact path and version of the plugins
  # ==> this lock file will be blocking if the version of plugin up/down graded in .tf files

#<=2.60  --> less than
#>2.10,<=2.30 --> inbetween

# tf init -upgrade ==> lock file will also be updated (so lock file will not block the update)

#Attributes and output values


