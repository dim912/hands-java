//TF automatically creates the dependency tree and create the resouces in order (looking at depndencies betwen reosuces )
//Ex : IF Ec2 depends on EIP, irrespecive of the order they are declared ==> TF first creates the EIP and then creates the EC2

// If the dependencies are not explicit, then at declration 'depends_on' can be used to excplictly mention the dependency
// If EC2 app depends on a S3( ex a provisioner is there to pull data from S3), then it is possible to mention on EC2 that it depends_on S3
// so TF will create those  in order

//when order does not matter == >

//tf generally loads all the configs in directory in alphabetical order
//files should be loaded in .tf or tf.json

//Other : for production --> it is recommanded to split the code into multiple configs files
