
alias k=kubectl
alias kdp='kubectl delete pod --force --grace-period=0'
k config set-context mycontext --namespace=mynamespace  #this only config the kubectl tool. But not anything related to cluster
:set expandtab #when copy convert tabs into spaces

kubctl cluster info
kubectl create namespace dev
kubectl config set-context $(kubectl config current-contxt) --namespace=dev #context is a different topic all together
alias kdp='kubectl delete pod --force --grace-period=0'

kubectl explain pods --recursive | grep envFrom -A3 -B5

kubectl get all
kubectl get pods
kubectl get pods --show-labels
kubectl get pods,svc
kubectl get pods --namespace kubsystem
kubectl get pods -o wide  #extra info
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces --no-headers
kubectl get pods --selector app=App1   #filter by selector
kubectl get netpol
kubectl delete pod --all
kubectl get po --selector env=prod,bu=finance,tier=frontend # here and condition between labels. if multiple --selector is used then or condition
kubectl describe pod mayapps-pod

#shorthand for resources
kubectl api-resources

#pod
kubectl run nginx --image nginx #create pod
kubectl run nginx --image nginx  --labels=env=prd,type=web --port:8080
kubectl run nginx --image=nginx --port=8080 --expose
kubectl run nginx --image nginx --dry-run=client -o yaml > pod.yml #create the declaration without actually sending the request to cluster
ubectl run redis --image=redis:alpine --labels=tier=db
kubctl edit pod redis #edit on the fly
kubectl apply -f pod.xml

#Kub controllers(brain behind kub) - replication controller
       # support running specified amount of controllers all time
       # support scaling based on demand
#replica set - newer version of replication controllers

#replication Controller
kubectl create -f rc-definition.yml
kubectl get replicationcontroller

#replicaset
kubectl get replicaset
kubectl delete replicaset
kubectl replace -f rc-definition.yml #has to modify file
kubectl scale --replicas=6 -f replicaset rc-name #no need to modify file

#deployment
kubectl create deployment nginx --image=nginx
kubectl create deployment nginx --image=nginx --replicas=4
kubectl scale deployment nginx --replicas=4 #scaling an existing deployment
kubectl delete deployment nginx    #this will deploy RS as well
kubectl get pod nginx -o yaml > pod-definition.yaml

#namespaces (defaults) - isolating resources
#default
#kube-system
#kube-public
#resurces can be defined for namespaces
#objects within the same namespace can directly call others by name
#example DNS entry
#db-service.dev.svc.cluster.local
#service.namepsace.<fully qualified cluster name>

#editing pods
#only below can be edited
  # containers.image
  # initcontainers.image
  # activeDeadlineSEconds
  # spec.tolerations

#can not edit (need to )
  # env variables
  # service acounts
  # resoure limits can not be edited

kubctl edit pod nginx #when non editable filed is touch, -> a temp yaml will be created
#if lock for edit. delete the pod and then create using the yaml
#best way to edit a any property of the POD is editing its deploymnet (this will auto delete and recreate the PODS with new configs)
kubectl edit deployment my-deployment

#config maps
kubectl create configmap app-config --from-literal=APP_COLOR_CM=blue  --from-literal=APP_COLOR_CM1=red
kubectl create configmap app-config --from-file=app_config.properties

#secret
kubectl create secret generic app-secret --from-literal=DB_HOST=mysql --dry-run=client -o yaml
kubectl create secret generic app-secret --from-file=secretfile.props --dry-run=client -o yaml

kubectl -n webhook-demo create secret tls webhook-server-tls \
    --cert "/root/keys/webhook-server-tls.crt" \
    --key "/root/keys/webhook-server-tls.key"

#serice accounts
#user accounts - for human users
#service accounts - which are used to interact with clusetre. Ex: user used by jenkins / dashboard etc.
#when a sa is created -> related secret gets auto created

kubectl create serviceaccount dashboard-sa #this create a token for the user. this token should be used to interact(bearer token) for http api
kubectl get serviceaccount
kubectl describe serviceaccount dashboard-sa
kubectl describe secret dashboard-sa-token-52qvb
#for apps internal to the cluster -> this token can be mount as a volume and use within the app (Ex: dahboard app running within the cluster)
#default service account :  there is a one for each namespace(named default).
#when pod is created by default the default service account token is mounted
#within the pod -> token is mounted as three different files
      # ca.crt , namespace, token
k exec -it redis ls /run/secrets/kubernetes.io/serviceaccount
k exec -it redis ls /run/secrets/kubernetes.io/serviceaccount
#default service accunt is very much restricted - only provide basic access


#kubernetes scheduler decide to which node a pod goes to
#if there are no enough free resouces in cluster -> kub keeps the new  pod in pending status with message insufficient cpu..
#by default kub assume a pod need : 0.5 CPU, 256 MB,

#taints(a property of node to repels pods) and tolerations(a property of the pod to ignore taints and attach) - this decide which pods goes where
#taints and tolleration does not attract any pods. but it only reject/accept if schedular attempt to scheule the pod

#Taint
kubectl taint nodes node-name key=value:taint-effect
kubectl taint nodes node-name app=blue:NoSchedule
kubectl taint nodes node1 key1=value1:NoSchedule- #remove taint(- do this)
#taint-effect -> what happen to pod if they do not tolarate taint
  #noSchedule  -> do not put the pod. but existing pods will keep until they are deleted
  #PreferNoSchedule -> try best not to place pod
  #NoExecute -> no new scheduling and existing pods will also be removed. (Removed pods will be direct deleted)

#toleratons -> a pod level config
#by defefult -> in master node there is traint not to scheule any worker pods since it is dedeicated for managemnt software
kubectl describe node kubemaster | grep taint

#node selectors (only for simple usecases. Ex: place the pod on large or small, or anything that is not small -> can not be achived though node selectors )
kubectl label nodes node-name key=value
kubectl label nodes node10 size=Large

#node affinity (to eunsure pods are placed on desired nodes)

#Multi Container PODs -. share life cycle, same network, PV.yaml.
    # SIDECAR - ex : login server which collect logs and forwared to server. Rus
         # contains the main app and a helper container which is essential but not a part of the main app
         #  Ex: login server which collect logs and fwd to server(ex: splunk agent). sync agenet, monitoring agent,
    # ADAPTER -
         # Ex: normalize/simplity the login output before sending to the splunk (aggregator)
    # AMBESIDER - a service which use to connect to DB
         # connect container to external world(like proxy)
         # Ex : connecting to multiple DBs (based on the evn connect to dev,uat,prod databases) - mysql-proxy
    # INIT container
         # Always runs to completion. once all init contiainers are complted, then only the app container stats
         # Ex: download all html files before starting the nginx app container to a shared container

#life cycle (conditions)
#Pending ->  -> podScheduled -> Initialized -> ContainersReady(when all containers started) -> Ready(Means ready to accept traffic)
#Ready means -> Importnat because LBs will be sending traffic once the container becomes to ready state
#So better bind Ready state of the app -> to the business readyness of the pod

#for this REadiness Probs can be used
      # to determine if the app is ready
      # /api/actuaator/info
      # for DB -> check if 3306 is up

kubectl logs -f nginx #container logs
kubectl exec webapp -- cat /log/app.log

#logs for multi container pods
kubectl logs -f mypod  container1
kubectl logs -f mypod  container2

#monitor kube -> no inbuild service
      #Heapster - old version of metrics server which is depricated now
      #Metrics server
          # in memory

# kubelet - receive instructions from master server and operate
# cAdvisor is a sub component of kublet which collect matrix from pod and push to matrix server

kubectl top node # pulls metrices from metrics server and show
kubectl top pod  #pulls metrices from metrics server and show

#Rolling Updates & Rolling Deployments and versioning


#stratergis
#ReCreate       - first destroy all and create new  -> #app is down between kill and create
#Rolling update- default stratergy is  Rolling Updates -> deploy pod by pod (app does not go down. A new rs is created with the the new udpates)

#once the changes are applied on deployment.yml file (Ex : updating the image of container)
kubectl apply -f deployment-definitio.yml
kubectl set image deployment/myapp-dployment nginx=nginx:1.9.1 --record #record flag saves the command used to create/udpate deploymnet in history(as change cause)

#when deploy   -> kub creates a new empty replica set, kill pods from old rs one by one and create pod by pod in new rs

#deploymnet status
kubectl rollout status deploymnet/myapp-deploymnet
kubectl rollout history deploymnet/mydeploymnet --revision=1

kubectl rollout undo deploymnet/myapp-deploymnet #kubenetees keep the definition file of previous deploymnet internally and apply it back
#when rollback ->  this kills the pods in new rs and bring pods up in new rs

#Jobs in Kube (Batch, Analytics - carry out a specific task and then finish)

#replica set -> speficic task to run all time
#Jobs  -> run a given task to complection
kubectl create job myjob --image=busy-box
kubectl create -f job-definition.yaml
kubectl delete job math-add-job

kubectl create cronjob my-cron-job  --schedule="0,15,30,45 * * * *" --image=busy-box
kubectl create -f cronjob-definition.yaml

######### NETWORKING ########3

#Services - helps connect apps together. loose coupling between microservices
kubectl create service nodeport my-svc --tcp=80
kubectl expose deployment simple-webapp-deploy --name=myservice --target-port=8080 --type=NodePort --port=8080 --dry=run -o yaml
k expose pod redis --port=23423 --name redis-service --dry-run=client -o yaml
k create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml #assume app=redis label
k expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml #create a service named ngnx with type nodePort
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml #pod labels as selectors


#ClusterIP     - SErvice creates a virtual IP inside cluster to enable communication to setup to backend apps. can be accessed by every pod and every node.
#NodePort      - make internal port accssible thorough a port on node even outside clusetr. This automatically creates a ClusterIP too. (using node IPs)
#LoardBalancer - prvison LB for distibution of load between servers

#NodePort - think as a virual server in node -  (pod - targetPort)80 -> (service -Port )80 -> (node - nodePort)30008 (NodePort is in valid range : 30000 - 32767)

#a service can be spraed in multipel nodes (with each node having multiple nodes) - so service can be access from any IP

#Cluster IP :  provides a single cluserIp or serviceName to provide group of pods ( works only within the cluster)
#LoadBalancer Type: Kube send a command to Kube provider(Ex: GCP) to provision a LB which has an external IP/TLS (https://mycompany.com)

#INGRESS
  # difference from services
      # users to access diferent service though a single url/<service>
      # load balancing
      # SSL termination
      # path/host based virtual routing
      # users to access diferent service though a single url/<service>
      # implement SSL security
      # still need to publish it as a NodePort or cloudeNativeL B
      # without nginx could have use nginx/ha-proxy/apache
      # ingress do not expose arbitary ports/protocols. exposing anything othre than http/https to internet need a service with NodePort or LB
      # Ingress Controller is a pre requisit before configure ingress resource(route details)

  #advantage - no longer require different loadbalencers(purchased from cloud provider) for different services

#ingress controller - can be in any namespace (but it serves the ingresses from all namespaces)
 # GCE/nginx, haproxy   - has to be deployed to cluster separatly
  # ex: nginx, haproxy, CGP HTTPS, GCE( and Nginx are supported by Kub), Istio
  # nginx - deployed as another deployment in cluster
  # need
        # nginx-controller (nginx)
        # a config map to be used by nginx
        # service to expose nginx
        # a service account (which is used by controller to know the status of other service objects)

#Ingress = ingress-resource - must reside within the namespace where the apps
     #www.my-online.com
         #by host
           #www.weare.my-online.com
           #www.video.my-online.com
          #by path
           #www.my-online.com/weare
           #www.my-online.com/video
# annotations:
#  nginx.ingress.kubernetes.io/rewrite-target: /  --> ingress to remove the matching path(postfix) from URL, since the backend is not designed to support it


#NETWORK/SECURITY POLICIES

#no way to create the network policy
# Ingress - incomming traffic ( like external app calls the web server) are ingress to web server
# Egress - web server traffic API server is egress to web server

# Kub is by default : "ALL ALLOW"

#network policies are executed by network solution of Kube. But not all network solutions support network policies
    #kub -router - support
    #Calico      - support
    #Romana      - support
    #Weave-net   - support
    #Flannel     - DO NOT support


#Volume
  #define within the pod spec and use inside the containers  (volume may be in node or a shared disk like AWS EBS)

# Persistent Volume (PV.yaml) - live in a cluster wide centrally created storage managed by the Kube Admin

# Usually PVs are created by the cluster admins and claims are created by the app Devs
# Once PVC are created they are 1-1 matched to PVs by Kub my best match basis
    # a large PV might get bind to a small PVC if there is no other better match. But then PVC will start showing the full PV capacity
# if there are no matching PVs -> PVC will be on Pending state until new PV is added to the cluster

kubectl delete persistentvolumeclaim myclaim
      #bu defult PV does not get deleted because (detault is persistentVolumeReclaimPolicy: Retain)
kubectl delete persistentvolumeclaim myclaim
kubectl delete persistentvolumeclaim myclaim  # remove data. but not PV

# if a PVC in use( which is being used by a POD) is deleted ->
# then it goes to Terminating Status(Stuck there). But as soon as POD is deleted, PVC goes from terminating state to deleted status
#and PV goes to Released status
#pod/container -> has to bind to PVC the say how other volums

#storage classes

  # in above setups -> there has to be a PV manually created when a PVC is required
  # this can be automated using storage calsses
  # here PCV directly calls refer the storage class and, then a PV get auto created a manul provisioning of a PV is not required
  # WaitForFirstConsumer flag -> allocates the space on disk/or cloud only when the first POD ask for volumes though PVC

#Stateful Sets
  # Ex: Let say for a mysql cluster below apps has to come in order
           # master comes up first -> this says one of the pods should be able to label as a master with constant host name. can not rely on IP address.
           # then slave1 comes up and clone data from master and establish replication from master
           # then slave2 comes up and clone data from slave1 and establish replication from master

  # this can be implemented with deploymnets - since order of pods comes up is not aguranteed with deploymnets

#stateful sets
   # similar deployments scalable, support rolling updates,
   # differences -> PODS are created in sequencial order
          # second POD is created only after the first POD is successfully created -> this ensure master is deployed first
          # each node gets unique index -> and a unique name containing the unique index (mysql-1 <- can be used as master, mysql-2, mysql-3)
          # This index is a stickey idenfifier (even POD get restart/recreated the index does not change)

#healess Service

#Security in Kubenetes

#Kube-api server
      # All Access is managed by the kube-apiserver (API server authenticate before executing)
      # Authenticated through - usernamepwd(BASIC auth)/ token/ certs/ Auth provider LDAP / Kerbroz / service account (Kub does not manage users by default except service accounts)
      # RBAC authorization - Role based authorization
      # between apps - by default all pods are accessible. can be resticted by network policies
      # Admins -
      # Developers
      # Bots(other apps or services UIs)

      #Basic Auth
          #prepare a file user-details.csv    (passwrod123, user1, u0001)
          #Optinaly can have group (passwrod123, user1, u0001(this is UID), group1)
          #restart the kube-api server with --basic-auth-file=user-details.csv
          #or is kubeadm tool is used to setup clusetr -> add above as a command and restart the apiserver
          #to access -> curl -v -k https:///mster-node-ip:6443/api/v1/pods -u "user1:pwd1"

          #create user details into a csv file /tmp/users/user-details.csv
             #     password123,user1,u0001
             #     password123,user2,u0002
             #     password123,user3,u0003
             #     password123,user4,u0004
             #     password123,user5,u0005

             #    --basic-auth-file=/tmp/users/user-details.csv -> add this to api-server params

    #token auth
          # prepare user-token-details.csv (with asdf2ufasdfasdfUNX2 , user1, u0001, group1)
          # and run with --token-auth-file=user-token-details.csv
          #to access -> curl -v -k https:///mster-node-ip:6443/api/v1/pods --header "AUthorization: Bearer <token>"


#Kube Config

#general way of accessing the kube APIs

curl https://my-kube-playground:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt

#using kube control command

kubectl get pods --server mykube-playground:6443
          --server-key admin.key
          --client-certificate admin.cert
          --certificate-authority ca.crt

#typing above every time is not an easy task -> hence move above configs to KubeConfig.yaml file, with this

kubectl get pods --kubeconfig config

#by default kubeconfig looks for a file under directory $HOME/.kube/config
#if the file is stored there -> no need to specify the config file with --kubeconfig= option

#this config file has three sections

#to view current
kubectl config view

#to use a non default context
kubectl config use-context research --kubeconfig ~/my-kube-config

#API Groups ( for APIs in KubeAPI server)
    # /version
    # /api (Called as core group)
              # Ex: ns/pods/rc/events/endpoints/nodes/bindings/pv/pvc/configmaps/secrets/services
    # /apis (called as named group) # all new features will be available here going froward
              # /apps   (this is the api group level)
                   #/v1
                      #/deployments (this is resource level)
                            # list (action level. verbs)
                            # get
                            # create
                            # delete
                            # update
                            # watch
                      #/replicasets
                      #/statefulserts
              # /extensions
              # /netowrking.k8s.io
                   #/v1
                      #/networkpolicies
              # /storage.k8s.io
              # /authentication.k8s.io
              # /certificates.k8s.io
                   #/v1
                      #/certificatesigningrequests
    # /healthz
    # /metrics
    # /logs  -> to integrate with thrid party log apps
    # /api/v1/pods

curl http://localhost:6443 -k
     --key admin.key
     --cert admin.cert
     --cacert ca.cert

#kubectl proxy client -> this wrapps the kubeAPI server. though kubectl proxy client does not need to provide the cert details. proxy use the KubeConfig file

#"kube proxy"(will be discussed) and "kubectl proxy"(to access kube api server) and different utils

#Authorization  (what can usr do after getting access to cluster)
    # Node base auth
          # kube APi server is accessed by users as well as kubelets within the nodes(to read write info about service/endpoints/nodes/pods/events)
          # Node authorizer is used for requets comming from kubelets
          # any request comming from sytem:nodes groups are granted the previledges
    # Attibute base auth
          # assocciate a user with certen previledges (dev-user can view/create/delete)
          # everytime a change is required (Ex : change previledges of a user -> have to manually edit the file and restart kubeAPI server)
    # Role base auth
          # first define a role with previledges and then associate the role to the users
          # more standard then attibute based auth
    # Webhook auth (= external auth providers for authorization)
          # Ex: Open Policy agent
    # other modes (can be set with --autohrizstion-mode=AlwaysAllow flag of authorization server)
          # AlywaywAllow  (Default mode)
          # AlywaywDeny

# Authorization mechanizam can be changed by authorization-mode flag at kube-apiserver configs
        # ex :authorization-mode=Node,RBAC,Webhook
        # when multiple modles are specificed -> request is evaluated in the order (Ex: in above example Node, RBAC, Webhook in order until one get permitted)


#Role Base Access Control (RBAC) - in detail
      # refer RABC directory

kubectl describe pod kube-apiserver-controlplane -n kube-system

kubectl get roles
kubectl get rolebindings
kubectl describe role developer #to view details of each user

kubectl describe rolebinding develoepr-bindings

#check if the logged in user has access to a certain action
kubectl auth can-i create deployments
kubectl auth can-i delete nodes

#impersonate and check
kubectl auth can-i create deployments --as dev-user --namespace testspace
kubectl auth can-i delete nodes --as dev-user --namespace testspace

#Cluster Roles and bindings (for cluster scoped resources)
    # for resources which are common to all name spaces
              # Ex :
              # - Nodes  (nodes are at cluster level)
              # - PV (nodes are at cluster level)
              # - clusterRole (nodes are at cluster level)
              # - clusterRolebidnings (nodes are at cluster level)
              # -namespaces (nodes are at cluster level)
   # ex : Cluster Admin, Storage Admin
   # ClusterRoles can be created for NS level resocues too -> then the user who gets the access will have access accorss all the NSs.

#Role and RoleBinding are at ==> API level. to go beyond that Admission Control is required

#Admision Controllers

        # Example use cases (impement below rules)
            # only permit images from certain registery
            # do not allo runAs root user
            # only permit certain capabilities
            # Pod always has labels
            # metadata must contain lables

        #Inbuild Admission contorller (which validate the reqeusts like kubectl run ..)
           # AlwaysPullImages
           # DefaultStorageClass
           # EventRateLimit
           # NamespaceAutoProvision
           # Namespcaeexit


#to know default enabled admisson controllers
kube-apiserver -h | grep enable-admission-plugins
#config file location
      /etc/kubernetes/manifests/kube-apiserver.yaml
       - --enable-admission-plugins=NodeRestriction,NamespaceAutoProvision
       - --disable-admission-plugins=DefaultStorageClass
#check what admission plugins are enabled/disabled
ps -ef | grep kube-apiserver | grep admission-plugins

kubectl exec kube-apiserver-controlplane -n kube-system --kube-apiserver -h | grep enalbe-admission-plugins

#to ammend the api admission contorller on api-server
 #modify -> --enable-admission-plugins= NodeRestiction,
              #NameSPaceLifeCyle (reject commdns if NS does noe exist. and default and public NSs can not be deleted) -enabled by default
              #NameSpaceAutoProvision(Auto create the NS when it is used in a create command for hte first time) - not enalbed by default


#Validating and Mutating Admission Controllers

   #Mutating Admission Controllers - mutate the request before it create (Applied before validating admission controllers)
        #DefaultStorageClass - where the PV should be created, if no storage class is mentioned in create PV
        #NamespaceAutoProvision -

   #Validating controllers
        # NameSpaceExists - reject the request if NS does not exist

  # To build the custom mutations/  WebHooks
        #can build webhooks as an external app and kube will call these apps for mutations and validations (Admission Webhook server)
        #pass a admission review request
        #webhook server will return true or false for allow.
               #Mutating admission WebHook
               #Vlidating admission WebHook

       # to integrate the webHook server to apiserver -> need to create a VlidatingWebhookConfiguration


# API Versions
     # Each API group has different versions
          # /v1 -> GA stable version (Generally available stable version)
          # /v1alpha1 -> first developed and available for the fist time in API suite (Not enabled by default. since there API are not gaurennteed to work well or available in future). these are only for expert users
          # /v1beta1 -> enabled by default. tested and confirmed. this will go to GA in future.

          #same API can be available with multiple versions. Ex: /apps   has /v1, /v1alpha1 , /v1beta1
          #but only one of above is marked as the preferred/storage version. so general kubectl commands refer this version. (only one can be preferred version)
          #for other versions, when changes are saved to etcd database, values will be auto converted to preferred/storage version


#enable disable API groups, add below in API server configs
       --runtime-config=batch/v2alpha1  # -> then has to restart the API server


#API Deprecation Policy

       # single API group can support multiple versions. how many should be supported ?
       #lifecyec of API - lets say we introduce /course, /webinar in a new API group /school
              # first version of School API group that will be merged to kub code base : /v1alpha1
       # APIs  can only be removed only be incrementing the version of the API group
            # /webinar can be only removed in vlalpha2
            # Ex : an API added to v1alpha1 can only be removed in v1alpha2 version. But not directly on v1alpha1.
            # now next kube version should support both v1alpah1 and v1alpha2
            # But set prefered/storage version to v1alpha2. (that says even v1alpha1 is used -> internally it will be converted to v1alpha2 and store)

       # API objects should be able to round-rip between API versions in a given release without info loss, which the exception of whole rest resouces do not exist in some version
            # Ex: v1alpha1 of Course spac support only type as the spec parameter
            # lets say now v1alpah2 is released to support spec parameters type and duration
            # here it must added duration into v1alpah1 as well.


        # now let say API is ready for beta release
            # first release /v1beta1 -> then goes to v1beta2 -> finally release /v1

        #older versions can be deprecated and removed over releases

        # other than most recent API version in each track, old API versions must be supported after their announced deprecation for duration no les than
            # GA  : 12 months or 3 release (which is longer)
            # Beta: 9 months or 3 release (which is longer)
            # Alpha: 0 releases

         # RELEAE    Available Versions
         #    X     -> v1alpah1 (first ever release which contain School API group)
         #    X+1   -> v1alpah2 (since it is still at alpha versions it is not required to keep alpha1 in the release) (this is a breaking update for users how were using the alpha1 api). So this has to be mentioned in the release notes
         #    X+2   -> v1beta1 (no need to contain v1alpa2)
         #    X+3   -> v1beta2 ( new beata version is released and v1beta1 will be still there in this release as deprecated. but is not removed. if anyone use v1beta1 -> a deprecation warning will be displayed)
                    # but still v1beta1 is the preferred version. this is because an new coming version can not be the preferred version in the first release itself
         #    X+4   -> both v1beta1 and v1beta2 are still available. but now v1beta2 is the preferred version
         #    X+5   -> lets say /v1 is added here. but v1beta2 is the preferred but both v1beta1 and v1beta2 both are deprecated
         #    X+6   -> v1 is preferred now. and v1alpha1 is removed
         #     .
         #     .
         #     .
         #     .
         #    X+4   -> v2alpha1 is introduced. But v1 is still preferred (can not deprecate v1 yet since v2 is only alpha yet). until /v2 is introduced can not deprecate /v1


   #kubectl convert command (once a api version is removed -> will require to to update existing definition files to new version)
   #this command is a plugin and not available by default in kubectl utility
   kubectl convert -f old-file.yaml --output-version apps/v1

#Custom Resource Definition

    # when resources are created -> their information/status are saved in ETCD database

    # Controllers - are responsible for manipulating the Kube Objects as per their definitions
        # Ex: when 'kubectl create Deployment' is called -> this is handled by the Deployment Controller
        # Controller continuously listen to the definition objects and accordingly provision changes

# Custom Controller
    # can write in any language. and run as a pod in the cluster itself. (this app is responsible to monitor changes to changes)

# Operator Framework
    # used to build and deploy CRD(Custom Resource Definition) and Controllers together as a single entity
    # Additional features
        # take backups
        # restore backups
   # operators are available at : https://operatorhub.io/


# Blue-Green strategy (additional to Recreate and Rolling{default} which were discussed before)
     # blue(labeled with version:v1)  - currently up and running and Service route traffic to it (selector on the service is => version:v1)
     # green(labeled with version:v2) - new version is deployed and tested. when looking fine, change the selector on the service to version:v2

# Canary Updates
    # Deploy a single pod of new version and only a small version of traffic it routed to the new version and test
    # if all looks good -> update the old deployment with new update with rolling updates

    # deploy(myapp-canary) v2 cluster with minimal possible number of pods (so onlya minimal traffic comes to canary deploymnet)
    # create a common label between old and new deployments
    # now use this common label at service as the selector

    #one disadvantage is : no control on the traffic that comes to canary. it is only limited by number of pods
        # Here Istio come handy where a controlled amount of traffic can be routed to the canary with out depending on the number of PODs


#HELM - package/release manager - treat apps as apps. (not as set of objects which is the case in Kub)

    # Kube is not aware about the eco system of the app (Deployment, services, PV, PVC, secret etc)
    # Helm - knows about the app - called as Package Manager (Group things like Deployment, Services... related with the app)
    helm install wordpress .... # creates all required kube objects required for wordpress
    helm update wordpress
    helm rollback wordpress
    helm uninstall wordpress

#HELM Concepts

    # creates templates of kube yaml definition files and then values are passed from helm config file (value.yaml)
    # together kube template yaml and value.yaml creates the helm chart
    # common charts can be found on repository https://artifacthub.io/
    help search hub wordpress #(community driven)
    #for other repos
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo list

    helm install [release-name] chartName
    #install from repo bitnami
    helm install bravo bitnami/drupal
    #install locally modified version (modified value.yaml file)
    helm install mywebapp ./apache

        #each installation is called as a release and each release has a release name
              helm install release-1 bitnamei/wordpress
              helm install release-2 bitnamei/wordpress
              helm install release-3 bitnamei/wordpress
        #each release is completely independent to each other
              helm uninstall release-1

        #download but do not install
              helm pull --untar bitnami/wordpress

        #list packages
              helm list
