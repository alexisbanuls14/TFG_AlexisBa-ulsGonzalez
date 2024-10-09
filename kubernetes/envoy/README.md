kubectl apply -f envoy/envoy-configmap.yaml -f envoy/envoy-service.yaml  -f envoy/envoy-deployment.yaml
kubectl apply -f locust/locustfile-cm.yaml -f locust/locust-loadbalancer.yaml -f locust/locust-master-deployment.yaml -f locust/locust-clusterip.yaml -f locust/locust-slave-hpa.yaml
kubectl delete pod -n kube-system -l k8s-app=kube-dns
kubectl apply -f locust/locust-slave-deployment.yaml

kubectl rollout restart deployment locust-worker


kubectl delete all --all -n load-testing
kubectl delete configmaps --all -n load-testing

kubectl port-forward deployment/envoy-deployment 9901:9901

2
kubectl exec -it test-pod -- /bin/sh
locust --headless --users 100 --spawn-rate 10 --run-time 10m -f locustfile.py

http://pagina-web.com/