kubectl apply -f envoy-configmap.yaml -f envoy-deployment.yaml -f envoy-service.yaml

kubectl delete -f envoy-configmap.yaml -f envoy-deployment.yaml -f envoy-service.yaml