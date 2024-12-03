postgresql://USER:PASSWORD@IP:PORT/DATABASE_NAME

kubectl create secret generic db-credentials --from-literal=DATABASE_URL="postgresql://USER:PASSWORD@IP:PORT/DATABASE_NAME"


Instala el Conector de Cloud SQL en Kubernetes:

Si tu clúster está en Google Kubernetes Engine (GKE), sigue esta configuración: Documentación del Conector de Cloud SQL.

Configura el Deployment.yaml:

Ajusta el Deployment para incluir el conector y establecer las variables INSTANCE_CONNECTION_NAME, DB_USER, y DB_PASS.

Modifica DATABASE_URL:

Si usas el conector, DATABASE_URL debe cambiar a algo como:

perl
Copiar código
postgresql+psycopg2://DB_USER:DB_PASS@/DATABASE_NAME?host=/cloudsql/YOUR_INSTANCE_CONNECTION_NAME


curl -X POST "http://34.90.65.106:8000/register" -H "Content-Type: application/json" -d '{"username":"newuser","password":"newpassword"}'


curl -X POST "http://34.90.65.106:8000/login" -H "Content-Type: application/json" -d '{"username":"pruebas","password":"newpassword"}'

curl -X GET "http://34.90.65.106:8000/verify-token?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwcnVlYmFzIiwiZXhwIjoxNzMyMzcxMDIzfQ.wcrbVfYTJHOs11xVjGkKSm77BNDOVb67-BCTvcjwP70"


