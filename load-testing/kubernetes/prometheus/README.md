kubectl apply -f prometheus/prometheus-configmap.yaml -f prometheus/prometheus-pvc.yaml -f prometheus/prometheus-service.yaml -f prometheus/prometheus-deployment.yaml 
kubectl apply -f grafana/grafana-service.yaml -f grafana/grafana-deployment.yaml 

kubectl delete -f prometheus/prometheus-configmap.yaml -f prometheus/prometheus-service.yaml -f prometheus/prometheus-deployment.yaml 
kubectl apply -f grafana/grafana-service.yaml -f grafana/grafana-deployment.yaml 

kubectl exec -it test-pod -- /bin/sh

kubectl config set-context --current --namespace=monitoring
kubectl config set-context --current --namespace=load-testing

kubectl delete all --all -n monitoring
kubectl delete configmaps --all -n monitoring

kubectl port-forward service/prometheus-server 9090:80 -n monitoring

kubectl apply -f envoy/envoy-configmap.yaml -f envoy/envoy-service.yaml  -f envoy/envoy-deployment.yaml
kubectl apply -f locust/locustfile-cm.yaml -f locust/locust-loadbalancer.yaml -f locust/locust-master-deployment.yaml -f locust/locust-clusterip.yaml -f locust/locust-slave-hpa.yaml
kubectl delete pod -n kube-system -l k8s-app=kube-dns
kubectl apply -f locust/locust-slave-deployment.yaml


kubectl delete all --all -n monitoring
kubectl delete configmaps --all -n monitoring