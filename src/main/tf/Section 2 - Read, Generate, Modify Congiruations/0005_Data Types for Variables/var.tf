# there are 6 possible data types

variable "sampleString" {
  type    = string
  default = "asdfasdf"
}

variable "sampleBoolean" {
  type    = bool
  default = false
}

variable "sampleNumber" {
  type    = number
  default = 324.223
}

variable "sampleList" {
  type    = list(string)
  default = ["asdf", "asfd23f"]
}

variable "sampleMap" { //tuples
  type = map(string)
  default = {
    "key" = "value"
  }
}

variable "sampleNull" { //objects
  type = null
}
# represent absense. 
