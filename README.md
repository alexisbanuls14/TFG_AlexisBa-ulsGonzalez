# TFG: Infraestructura Cloud para Pruebas de Carga Distribuida

## Descripción

Este proyecto tiene como objetivo desplegar una infraestructura en Google Cloud utilizando Kubernetes, Terraform, Locust y Envoy Proxy para realizar pruebas de carga distribuidas en microservicios. El entorno permite generar tráfico simulado y monitorizar el rendimiento en tiempo real con Prometheus y Grafana.

## Requisitos Previos

- **[Google Cloud SDK](https://cloud.google.com/sdk/docs/install)**
- **[Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)**
- **[kubectl](https://kubernetes.io/docs/tasks/tools/)**
- **[Docker](https://docs.docker.com/get-docker/)** (opcional)

## Instalación y Configuración

Para las instrucciones detalladas de instalación y despliegue, consulta [docs/setup.md](docs/setup.md).

## Arquitectura del Proyecto

La infraestructura del proyecto incluye:

- **Google Kubernetes Engine (GKE)**: Clúster Kubernetes gestionado.
- **Envoy Proxy**: Balanceo de carga y monitorización de tráfico.
- **Locust**: Generación de tráfico distribuido para pruebas de carga.
- **Prometheus y Grafana**: Recolección y visualización de métricas de rendimiento.

## Documentación

Para más detalles sobre los componentes del proyecto, revisa la documentación en el directorio `docs/`.
