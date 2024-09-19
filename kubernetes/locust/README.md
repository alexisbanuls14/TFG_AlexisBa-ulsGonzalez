kubectl apply -f scripts-cm.yaml -f service.yaml -f slave-deployment.yaml -f master-deployment.yaml 


kubectl delete -f scripts-cm.yaml -f service.yaml -f slave-deployment.yaml -f master-deployment.yaml


kubectl delete all --all -n locust-namespace
