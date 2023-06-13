variable "serverNames" {
  type = map(string)
  default = {  //if no default value is not set ==> tf prompt the values at tf plan, tf apply..etc. Or has to inject from terraform.tfvars file
    app_server= "app_server"
    web_server= "web_server"
  }
}

//local variables (all goes inside one or few locals blocks)
//can be used t keep the repetitive values
locals  {
  ami_lookup= tomap({ //types ae auto derived from the type of data. ( no speciric type is needed here)
    "asia" = "ami-025468ad3c42e0236", //private, nginx installed
    "emea" = "ami-0f4cbe219b113d960"
  })
}