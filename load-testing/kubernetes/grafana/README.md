kubectl apply -f .\grafana-configmap.yaml -f .\grafana-dashboard.yaml -f .\grafana-datasource.yaml -f .\grafana-deployment.yaml -f .\grafana-mount-dashboard.yaml -f .\grafana-secret.yaml -f .\grafana-service.yaml

kubectl delete -f .\grafana-configmap.yaml -f .\grafana-dashboard.yaml -f .\grafana-datasource.yaml -f .\grafana-deployment.yaml -f .\grafana-mount-dashboard.yaml -f .\grafana-secret.yaml -f .\grafana-service.yaml

admin
my-secret-password
kubectl get secret grafana -n monitoring -o jsonpath="{.data.admin-user}" | base64 --decode ; echo
kubectl get secret grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo