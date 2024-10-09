# Create secret with grafana credentials
kubectl create secret generic grafana -n projectcontour-monitoring \
    --from-literal=grafana-admin-password=admin \
    --from-literal=grafana-admin-user=admin