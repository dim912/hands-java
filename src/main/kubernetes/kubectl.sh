kubectl get all
kubectl get pods
kubectl get pods --namespace kubsystem
kubectl get pods -o wide
kubectl run nginx --image nginx #create pod
kubectl run nginx --image nginx --dry-run=client -o yaml > pod.yml
kubectl apply -f pod.xml
kubctl edit pod redis
kubectl describe pod mayapps-pod
kubctl delete deployment nginx
kubectl get pod nginx -o yaml > pod-definition.yaml

#Kub controllers(brain behind kub) - replication controller
       # support running specified amount of controllers all time
       # support scaling based on demand

#replica set - newer version of replication controllers

kubectl create -f rc-definition.yml
kubectl get replicationcontroller

kubectl get replicaset
kubectl delete replicaset
kubectl replace -f rc-definition.yml #has to modify file
kubectl scale --replicas=6 -f replicaset rc-name #no need to modify file

#namespaces (defaults) - isolating resources
#default
#kube-system
#kube-public

#resurces can be defined for namespaces
#objects within the same namespace can directly call others by name

#example DNS entry
#db-service.dev.svc.cluster.local
#service.namepsace.<fully qualified cluster name>

kubectl create namespace dev
kubectl config set-context $(kubectl config current-contxt) --namespace=dev #context is a diffent topic all together
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces --no-headers

--dry-run=client #tells if the resouce can be created if comamnd is right




























