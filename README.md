TFG: Infraestructura Cloud para Pruebas de Carga Distribuida
Descripción

Este proyecto tiene como objetivo desplegar una infraestructura en la nube utilizando Google Cloud, Kubernetes, Terraform, Locust y Envoy Proxy para realizar pruebas de carga en microservicios. El entorno está diseñado para generar y monitorear tráfico distribuido, simulando condiciones de tráfico realista para evaluar la escalabilidad y rendimiento de microservicios en Kubernetes.
Requisitos Previos

Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas:

    Google Cloud SDK: Para gestionar recursos en Google Cloud.
    Terraform: Para el despliegue automatizado de la infraestructura.
    kubectl: Para interactuar con el clúster Kubernetes.
    Docker (opcional): Para realizar pruebas locales de contenedores.

Instrucciones de Instalación
1. Clonar el repositorio:

bash

git clone https://github.com/tu_usuario/TFG-Cloud-Load-Testing.git
cd TFG-Cloud-Load-Testing

2. Configurar y desplegar la infraestructura con Terraform:

bash

cd terraform
terraform init
terraform apply

3. Desplegar los microservicios en Kubernetes:

bash

cd kubernetes
kubectl apply -f deployments/
kubectl apply -f services/

4. Ejecutar pruebas de carga con Locust:

bash

cd locust
locust -f locustfile.py

Arquitectura del Proyecto

La infraestructura del proyecto incluye los siguientes componentes clave:

    Google Kubernetes Engine (GKE): Clúster Kubernetes gestionado.
    Envoy Proxy: Balanceo de carga y monitoreo de tráfico.
    Locust: Generación de tráfico distribuido para pruebas de carga.
    Prometheus y Grafana: Recolección y visualización de métricas de rendimiento y tráfico.
