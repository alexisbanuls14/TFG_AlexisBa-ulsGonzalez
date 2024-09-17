# TFG: Infraestructura Cloud para Pruebas de Carga Distribuida

## Descripción
Este proyecto tiene como objetivo crear una infraestructura cloud utilizando Google Cloud, Kubernetes, Terraform, Locust y Envoy Proxy para realizar pruebas de carga en microservicios.

## Requisitos Previos
- **Google Cloud SDK**: [Instalar Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- **Terraform**: [Instalar Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **kubectl**: [Instalar kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- **Docker** (opcional): Para pruebas locales

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
