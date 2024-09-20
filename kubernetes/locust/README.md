kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml


kubectl delete -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml






kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-slave-hpa.yaml


kubectl delete -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-slave-hpa.yaml






kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml


kubectl delete -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml


kubectl delete all --all -n locust-namespace


kubectl apply -f locustfile-cm.yaml -f locust-service.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml


kubectl delete -f locustfile-cm.yaml -f locust-service.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml



kubectl apply -f locustfile-cm.yaml -f locust-loadbalancer.yaml -f locust-master-deployment.yaml -f locust-slave-deployment.yaml -f locust-clusterip.yaml -f locust-slave-hpa.yaml