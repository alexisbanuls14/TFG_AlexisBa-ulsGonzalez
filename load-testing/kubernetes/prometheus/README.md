kubectl apply -f .\prometheus-configmap.yaml -f .\prometheus-deployment.yaml -f .\prometheus-pvc.yaml -f .\prometheus-service.yaml

kubectl destroy -f .\prometheus-configmap.yaml -f .\prometheus-deployment.yaml -f .\prometheus-pvc.yaml -f .\prometheus-service.yaml