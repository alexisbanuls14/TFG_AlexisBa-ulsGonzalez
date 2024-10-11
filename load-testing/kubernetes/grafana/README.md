kubectl apply -f prometheus/prometheus-configmap.yaml -f prometheus/prometheus-pvc.yaml -f prometheus/prometheus-service.yaml -f prometheus/prometheus-deployment.yaml 
kubectl apply -f grafana/grafana-service.yaml -f grafana/garfana-mount-dashboard.yaml -f grafana/grafana-deployment.yaml -f grafana/grafana-configmap.yaml -f grafana/grafana-secret.yaml -f grafana/grafana-datasource.yaml -f grafana/grafana-dashboard.yaml

kubectl delete -f grafana/grafana-service.yaml -f grafana/garfana-mount-dashboard.yaml -f grafana/grafana-deployment.yaml -f grafana/grafana-configmap.yaml -f grafana/grafana-secret.yaml -f grafana/grafana-datasource.yaml -f grafana/grafana-dashboard.yaml
kubectl delete -f prometheus/prometheus-configmap.yaml -f prometheus/prometheus-pvc.yaml -f prometheus/prometheus-service.yaml -f prometheus/prometheus-deployment.yaml 

kubectl config set-context --current --namespace=monitoring
kubectl config set-context --current --namespace=load-testing

kubectl delete all --all -n load-testing
kubectl delete configmaps --all -n load-testing

kubectl port-forward service/prometheus-server 9090:80 -n monitoring

kubectl apply -f envoy/envoy-configmap.yaml -f envoy/envoy-service.yaml  -f envoy/envoy-deployment.yaml -f envoy/envoy-hpa.yaml
kubectl apply -f locust/locustfile-cm.yaml -f locust/locust-loadbalancer.yaml -f locust/locust-master-deployment.yaml -f locust/locust-clusterip.yaml -f locust/locust-slave-hpa.yaml
kubectl delete pod -n kube-system -l k8s-app=kube-dns
kubectl apply -f locust/locust-slave-deployment.yaml
kubectl apply -f prometheus/prometheus-configmap.yaml -f prometheus/prometheus-pvc.yaml -f prometheus/prometheus-service.yaml -f prometheus/prometheus-deployment.yaml 
kubectl apply -f grafana/grafana-service.yaml -f grafana/grafana-mount-dashboard.yaml -f grafana/grafana-deployment.yaml -f grafana/grafana-configmap.yaml -f grafana/grafana-secret.yaml -f grafana/grafana-datasource.yaml -f grafana/grafana-dashboard.yaml

kubectl delete all --all -n monitoring
kubectl delete configmaps --all -n monitoring

admin
my-secret-password
kubectl get secret grafana -n monitoring -o jsonpath="{.data.admin-user}" | base64 --decode ; echo
kubectl get secret grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


link prometheus: http://prometheus-server.monitoring.svc.cluster.local