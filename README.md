# TFG: Infraestructura Cloud para Pruebas de Carga Distribuida

## Descripción

Este proyecto tiene como objetivo desplegar una infraestructura en la nube utilizando Google Cloud, Kubernetes, Terraform, Locust y Envoy Proxy para realizar pruebas de carga en microservicios. El entorno está diseñado para generar y monitorear tráfico distribuido, simulando condiciones de tráfico realista para evaluar la escalabilidad y rendimiento de microservicios en Kubernetes.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas:

- **[Google Cloud SDK](https://cloud.google.com/sdk/docs/install)**: Para gestionar recursos en Google Cloud.
- **[Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)**: Para el despliegue automatizado de la infraestructura.
- **[kubectl](https://kubernetes.io/docs/tasks/tools/)**: Para interactuar con el clúster Kubernetes.
- **[Docker](https://docs.docker.com/get-docker/)** (opcional): Para realizar pruebas locales de contenedores.

## Instrucciones de Instalación
1. Clonar el repositorio:
    ```bash
    git clone https://github.com/tu_usuario/TFG-Cloud-Load-Testing.git
    cd TFG-Cloud-Load-Testing
    ```

2. Configurar y desplegar la infraestructura con Terraform:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```

3. Desplegar microservicios en Kubernetes:
    ```bash
    cd kubernetes
    kubectl apply -f deployments/
    kubectl apply -f services/
    ```

4. Ejecutar pruebas de carga con Locust:
    ```bash
    cd locust
    locust -f locustfile.py
    ```

## Arquitectura del Proyecto
La infraestructura incluye:
- Un clúster Kubernetes gestionado por GKE.
- Microservicios balanceados con Envoy Proxy.
- Pruebas de carga distribuidas con Locust.
- Monitoreo de tráfico y métricas con Prometheus y Grafana.
