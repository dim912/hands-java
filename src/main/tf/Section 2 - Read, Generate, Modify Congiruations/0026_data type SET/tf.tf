variable "iam_names" {
 type = list
 default = ["user-01","user-02","user-03"] //ordered , allow duplicates, changable
}

//set --> multiple items in same variable, un ordered, no duplicate
variable "iam_names_set" {
  type = set()
  default = ["user-01","user-02","user-03"]
}

//terraform has a function as toset
toset(["a","b","c"])  ==> will return "b", "c"

