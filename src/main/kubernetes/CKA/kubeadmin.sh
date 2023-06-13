
#cluster Archetecture
    # contain set of nodes
       #  workload nodes
       #  master node (control node)
            #  done by control plane components -> are build as containers
               #  ETCD cluster
               #  schedulars - identify the right node to place the workloard
               #  nodeController - onboard new nodes to cluster / handling situations where nodes are unavailable
               #  ReplicationController - desired number of PODs are running
               #  KubeAPI server - enable communication between above contorllers / operations  / allow external users to configure/manage / worker nodes communicates to API server
               #  networking solutions/monitoring solutions
            # has the ETCD which contains the informaton about the cluster

      #docker has to be installed on all nodes
      #all nodes has an engine which takes to the master node. This engine is KUBELET ( runs on each node )
          #kubelet knows how to create/delete/manage containers on nodes (Kubelet is the Captain on the each workload node)
      #all nodes has a components as kub-prox service which enables the networking between the containers


      #ETCD
          # Reliable distributed key-value store (runs on port 2379)
          # ETCD control client is the comand line client for ETCD
          # node,pods, config, secret, rolebinding ... etc is in ETCD
          # ETCH can be configured with HA (High Availability)


      # there are two ways to install Kube
          # from scretch ( manually )
          # using kubeadm tool

      # advertise cleint urls --> this property should be configured on kubeAPI server (then API server knows how to reach ETCH)

     #Kube API server ( primary managemnet component in K8s) - at the center of every thing
             # Authenticate user
             # Validate Requests
             # Retrive Data
             # Udpate ETCH - API server is the only component which interacts to the ETCH database
             # Schedular
             # Kubelet

    # If kube is deployed using kubeadmin
            # the api-server is placed on master node by the kubeadm in kube-admin namespace
                  # consig is on etc/kubernetes/manifest/kueb-apiserver.yaml
            # on the non kubeadmin setup
                  # cat /etc/systemd/system/kube-apiserver.services
                  # can use 'ps' to locate the kubeadmin servercat /etc/systemd/system/kube-apiserver.services

    # If kube is deployed using kubeadmin
            # the api-server is placed on master node by the kubeadm in kube-admin namespace


