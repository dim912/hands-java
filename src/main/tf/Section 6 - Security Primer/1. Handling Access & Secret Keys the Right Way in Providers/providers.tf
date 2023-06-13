//set credentails on aws cli

provider "aws" {
//  access_key = "asdf"  this two are not needed since access key information are setup on aws cli
//  secret_key = "asdf"
  region     =  "us-west-1" //if this is removed, tf plan will ask the region on a prompt. so can run run scrpits on multiple envs too
}