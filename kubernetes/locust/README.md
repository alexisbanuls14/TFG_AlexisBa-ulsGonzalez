kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml -f locust-slave-hpa.yaml


kubectl delete -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml -f locust-slave-hpa.yaml


kubectl delete all --all -n locust-namespace

POR SI HAY PROBLEMAS CON LA CONEXION MASTER-SLAVE

kubectl delete pod -n kube-system -l k8s-app=kube-dns
