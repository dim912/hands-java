
##install docker https://docs.docker.com/desktop/mac/install/
#download -> double click -> drag to application folder -> search and start docker ( this installs docker to cmd )

#install Minikube  https://minikube.sigs.k8s.io/docs/start/
su admin
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube

#start cluster
minikube start

#UI dashboard
minikube dashboard

#create a sample deploymnet and expse on 8080
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-minikube --type=NodePort --port=8080

#launch web browser
kubectl get services hello-minikube

#prt forwarding
minikube service hello-minikube
##http://localhost:7080/.

kubectl port-forward service/hello-minikube 7080:8080

#manage cluster
minikube pause
minikube unpause
minikube stop
minikube config set memory 16384 #need a restart
minikube addons list #catalog of installed services
minikube start -p aged --kubernetes-version=v1.16.1 #install an old kub cluster
minikube delete --all



