//localpath
module "demomodule" {
  source = "../asdfasdf" // or ./xxxxxxxxxxxx
}

module "demomodule" {
  source = "git::https://github.com/zealvora/tmp-repo.git" //will checkout the default branch //git via ssh is also supported
}

module "demomodule" {
  source = "git::https://github.com/zealvora/tmp-repo.git?ref=development" //override the branch
}

module "demomodule" {
  source = "github.com/zealvora/tmp-repo"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"
}

//terraform init

