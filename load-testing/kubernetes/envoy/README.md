kubectl apply -f .\envoy-configmap.yaml -f .\envoy-deployment.yaml -f .\envoy-hpa.yaml -f .\envoy-service.yaml

kubectl delete -f .\envoy-configmap.yaml -f .\envoy-deployment.yaml -f .\envoy-hpa.yaml -f .\envoy-service.yaml