DESPLEGAR TODO

kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-clusterip.yaml -f locust-slave-hpa.yaml 

kubectl delete pod -n kube-system -l k8s-app=kube-dns

kubectl apply -f locust-slave-deployment.yaml

ELIMINAR TODO2

kubectl delete -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml -f locust-slave-hpa.yaml