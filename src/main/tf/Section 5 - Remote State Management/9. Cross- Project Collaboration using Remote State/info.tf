/*
connecton Remote states


terraform_Remote_State ==> retrive the root module output values from some otehr tf confs, usin the latest snapshot from hte remote backend

Ex :public IP project  - handle by network teams -- has its own state file
Ex :security  group - handle by security team --

so security gropu project --> can pull hte OUTPUT ( output is part of state) of tf_remote_state and use the details from it on security project







*/