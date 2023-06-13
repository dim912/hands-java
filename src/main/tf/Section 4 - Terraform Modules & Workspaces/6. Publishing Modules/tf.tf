//publishing modules to tf registery

//anyone can publish modules to TF registry, support versioning, generate docs, allow browing version history, show examples and readme

//requirments

//module should be on github and should be a public repo
//name as terraform-provider-name
//repo description ( on github description )
//should have x.y.z tags for releases  ex: 1.0.4 2.4.1

//minimal module format
//README.md
//ec2_with_httpd_installed.tf
//variables.tf
//outputs.tf

//complete-module format

//minimal module format ++
//modules/
      /nestedA/
          readme.md
          main.tf
          variaables.tf
          ouput.tf
     /nestedA/
          readme.md
          main.tf
          variaables.tf
          ouput.tf
//examples/
     /exampleA
          main.tf
     /exampleB
          main.tf
