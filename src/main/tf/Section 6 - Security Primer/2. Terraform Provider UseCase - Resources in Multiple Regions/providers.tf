provider "aws" {
  region     =  "us-west-1" //if this is remove, tf plan will prompt the region
}

//provider "aws" { //can not have two like this since tf commands does not exactly know which resgion to use
//  region     =  "us-west-2"
//}

provider "aws" {
  alias      =  "aws02"    //  allows to have multiple configs in same provider
  region     =  "ap-south-1"
}