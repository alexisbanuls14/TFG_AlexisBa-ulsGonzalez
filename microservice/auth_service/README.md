


export DATABASE_URL="postgresql://authuser:supersecurepassword@/authdb?host=/cloudsql/mitfgalexisbanuls:europe-west4:auth-db-instance"

kubectl create secret generic db-credentials \
    --from-literal=DATABASE_URL="postgresql://authuser:securepassword@/authdb?host=/cloudsql/mitfgalexisbanuls:europe-west1:auth-db-instance"


docker build -t auth-service:latest .
docker tag auth-service:latest alexisbanuls/auth-service:latest
