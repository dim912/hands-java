variable "instanceType" {
  default = "t4g.micro" #if no comand value arg or no tfvars file then value is picked from default
  #but the best option is to ==> move all of these vars to a tfvars file
  # export TV_VAR_instanceTYpe="t4g.micro" # passin the var values from from env varibale
  # to assign a value at run pass the value on command line. otherwise the default value will be applied
     #tf plan -var="instanceType=t2.small"

  # precedence
  # default < env varibale < tfvars file <  cmd line as "-var or -var-file"

  #if there is a varilbe which is not defined and there is no default value deined
        # then at tf plan and tf apply time --> there will be an prompt asking to set the value


}