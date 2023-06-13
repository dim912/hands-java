docker run ubuntu #run bash and imediatly exist
docker run ubuntu sleep 5 #sleep 5 overrides the default command

#start command in docker file
cmd sleep 5
cmd ["sleep", "5"]

#build new image
docker build -t ubuntu-sleeper .

#passing arguments to container
entrypoint ["sleep"] #now the arguments will be get appended to entrypoint(unlike cmd)
docker build -t ubuntu-sleeper .
docker run ubuntu-sleeper 10

#with default value for argument
entrypoint ["sleep"] #now the arguments will be get appended to entrypoint(unlike cmd)
cmd ["5"]
docker build -t ubuntu-sleeper .
docker run ubuntu-sleeper

#modify entry point during runtime

docker run ubuntu-sleeper --entrypoint <command>
docker run ubuntu expr 1+2

#run container -p hostPort:containerPort
docker run -p 8282:8080 kodekloud/simple-webapp

#to see the layers
docker  history python:3.6

#get the base image data of a docker image
docker run python:3.6 cat /etc/*release*

#to use an small image -> use alpine images
#FROM python:3.6-alpine





