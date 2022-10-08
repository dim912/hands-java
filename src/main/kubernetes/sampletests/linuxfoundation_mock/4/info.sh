#list 
helm search hub
helm search repo

#list releases
helm list

#unistall a release
helm uninstall internal-issue-report-apiv1

#upgrade a release
helm upgrade internal-issue-report-apiv2  bitnami/nginx


#download a chart
helm pull bitnami/apache --untar


#list deployed revisions
helm history internal-issue-report-apache 

#list rollback to a revision
helm rollback internal-issue-report-apache 1

#show values of a chart
helm show values bitnami/nginx

#install chart with custom values
helm install -f values.yaml internal-issue-report-apache ./apache

#install with overriden value
helm install --set replicaCount=2 internal-issue-report-apache ./apache
