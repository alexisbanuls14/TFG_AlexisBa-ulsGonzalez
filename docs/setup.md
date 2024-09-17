# Configuración del Proyecto

Este documento proporciona una guía paso a paso para configurar y desplegar la infraestructura cloud para pruebas de carga distribuidas en Google Cloud utilizando Terraform, Kubernetes, Locust, Envoy Proxy, Prometheus y Grafana.

## Requisitos Previos

Antes de comenzar, asegúrate de tener los siguientes componentes instalados en tu sistema:

- **[Google Cloud SDK](https://cloud.google.com/sdk/docs/install)**: Para autenticarte y gestionar recursos en Google Cloud.
- **[Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)**: Para definir y desplegar la infraestructura en la nube.
- **[kubectl](https://kubernetes.io/docs/tasks/tools/)**: Para gestionar el clúster de Kubernetes.
- **[Docker](https://docs.docker.com/get-docker/)** (opcional): Para pruebas locales de contenedores.

## 1. Autenticación en Google Cloud

Primero, autentícate en tu cuenta de Google Cloud usando `gcloud`:

```bash
gcloud auth login

Luego, selecciona tu proyecto de Google Cloud:

bash

gcloud config set project [PROJECT_ID]

2. Configuración del proyecto en Google Cloud

Si no tienes un proyecto, crea uno:

bash

gcloud projects create [PROJECT_ID]
gcloud config set project [PROJECT_ID]

Activa las APIs necesarias:

bash

gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com

3. Desplegar la Infraestructura con Terraform
3.1. Configurar variables

Navega al directorio terraform/ e inicia Terraform:

bash

cd terraform
terraform init

Modifica el archivo variables.tf con los valores necesarios para tu infraestructura, como el ID del proyecto de Google Cloud y la región.
3.2. Desplegar la infraestructura

Ejecuta los siguientes comandos para desplegar la infraestructura:

bash

terraform apply

Confirma el despliegue escribiendo yes cuando se te solicite.

Esto creará el clúster de Kubernetes (GKE) y cualquier otro recurso necesario en Google Cloud.
4. Desplegar los Microservicios en Kubernetes
4.1. Configurar kubectl

Descarga las credenciales para tu clúster GKE y configura kubectl para interactuar con él:

bash

gcloud container clusters get-credentials [CLUSTER_NAME] --region [REGION]

4.2. Desplegar los microservicios

Aplica los despliegues y servicios de Kubernetes definidos en el directorio kubernetes/:

bash

kubectl apply -f kubernetes/deployments/
kubectl apply -f kubernetes/services/

Esto desplegará los microservicios y configurará Envoy Proxy para gestionar el tráfico.
5. Configuración de Envoy Proxy

El archivo de configuración de Envoy Proxy se encuentra en kubernetes/envoy/. Revisa la configuración y aplícala si es necesario:

bash

kubectl apply -f kubernetes/envoy/envoy-config.yaml

6. Ejecutar Pruebas de Carga con Locust
6.1. Instalar dependencias de Locust

Navega al directorio locust/ e instala las dependencias de Python:

bash

pip install -r locust/requirements.txt

6.2. Ejecutar Locust

Inicia las pruebas de carga:

bash

locust -f locust/locustfile.py

Luego abre tu navegador en http://localhost:8089 para acceder a la interfaz de Locust y comenzar a generar tráfico hacia los microservicios.
7. Monitoreo de la Infraestructura
7.1. Desplegar Prometheus y Grafana

Navega al directorio monitoring/ y aplica las configuraciones de Prometheus y Grafana:

bash

kubectl apply -f monitoring/prometheus/
kubectl apply -f monitoring/grafana/

7.2. Acceder a Grafana

Una vez desplegado, accede a Grafana para visualizar las métricas:

bash

kubectl port-forward svc/grafana 3000:3000

Luego abre tu navegador en http://localhost:3000 y utiliza las siguientes credenciales por defecto:

    Usuario: admin
    Contraseña: admin

Configura Prometheus como fuente de datos en Grafana y carga los dashboards desde monitoring/grafana/dashboards/.
8. Limpieza de Recursos

Cuando hayas terminado de ejecutar las pruebas y analizar los resultados, puedes destruir la infraestructura para evitar incurrir en costos adicionales:

bash

terraform destroy

Conclusión

Siguiendo estos pasos, habrás desplegado una infraestructura completa en Google Cloud para realizar pruebas de carga distribuidas en microservicios, utilizando Kubernetes, Envoy Proxy, Locust, Prometheus y Grafana. Si tienes alguna duda o problema, revisa la documentación o abre un issue en el repositorio.