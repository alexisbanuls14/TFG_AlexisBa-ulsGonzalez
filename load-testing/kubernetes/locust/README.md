DESPLEGAR TODO

kubectl apply -f .\locust-clusterip.yaml -f .\locustfile-cm.yaml -f .\locust-loadbalancer.yaml -f .\locust-master-deployment.yaml -f .\locust-slave-hpa.yaml
kubectl delete pod -n kube-system -l k8s-app=kube-dns
kubectl apply -f .\locust-slave-deployment.yaml

kubectl delete -f .\locust-clusterip.yaml -f .\locustfile-cm.yaml -f .\locust-loadbalancer.yaml -f .\locust-master-deployment.yaml -f .\locust-slave-deployment.yaml -f .\locust-slave-hpa.yaml