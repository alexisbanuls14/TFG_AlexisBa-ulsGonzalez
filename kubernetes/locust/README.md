kubectl apply -f locust-configmap.yaml -f locust-loadbalancer.yaml -f locust-service.yaml -f locust-worker-hpa.yaml -f locust-master-deployment.yaml -f locust-worker-deployment.yaml


kubectl delete -f locust-configmap.yaml -f locust-loadbalancer.yaml -f locust-service.yaml -f locust-worker-hpa.yaml -f locust-master-deployment.yaml -f locust-worker-deployment.yaml