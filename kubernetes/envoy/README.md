kubectl apply -f envoy-configmap.yaml -f envoy-service.yaml  -f envoy-deployment.yaml

kubectl delete -f envoy-configmap.yaml -f envoy-deployment.yaml -f envoy-service.yaml


kubectl apply -f envoy/envoy-configmap.yaml -f envoy/envoy-service.yaml  -f envoy/envoy-deployment.yaml
kubectl apply -f locust/locustfile-cm.yaml -f locust/locust-loadbalancer.yaml -f locust/locust-master-deployment.yaml -f locust/locust-clusterip.yaml -f locust/locust-slave-hpa.yaml
kubectl delete pod -n kube-system -l k8s-app=kube-dns
kubectl apply -f locust/locust-slave-deployment.yaml
kubectl apply -f ../service/nginx.yaml -f ../service/service.yaml
kubectl get pods
kubectl get svc


kubectl delete all --all -n load-testing
kubectl delete configmaps --all --n load-testing

kubectl port-forward deployment/envoy-deployment 9901:9901


-f locust/locust-worker-network-policy.yaml

kubectl delete -f envoy/envoy-configmap.yaml -f envoy/envoy-service.yaml  -f envoy/envoy-deployment.yaml