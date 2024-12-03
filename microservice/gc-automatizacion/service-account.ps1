# Variables de configuración
$ProjectId = (gcloud config get-value project)  # Obtiene el ID del proyecto configurado
$ServiceAccountName = "terraform-service-account-ms"
$KeyFilePath = "C:\Users\alexi\Desktop\TFG_AlexisBanulsGonzalez\terraform-service-account-ms.json"

# Confirmar que hay un proyecto configurado
if (-not $ProjectId) {
    Write-Host "No hay un proyecto configurado en gcloud. Usa 'gcloud config set project PROJECT_ID' para configurarlo." -ForegroundColor Red
    exit 1
}

# Crear la cuenta de servicio
Write-Host "Creando cuenta de servicio..."
gcloud iam service-accounts create $ServiceAccountName `
  --display-name "Cuenta para Terraform"

# Asignar permisos necesarios
Write-Host "Asignando roles a la cuenta de servicio..."
$Roles = @(
    "roles/container.admin",                # Administración de Kubernetes Engine
    "roles/compute.admin",                 # Administración de Compute Engine (redes, IPs, NAT)
    "roles/iam.serviceAccountUser",        # Permite usar la cuenta de servicio
    "roles/storage.admin",                 # Administración de buckets de almacenamiento
    "roles/monitoring.admin",              # Acceso a servicios de monitoreo
    "roles/logging.admin",                 # Acceso a servicios de logging
    "roles/cloudsql.client",                # Acceso a Cloud SQL
    "roles/cloudsql.admin",
    "roles/servicenetworking.networksAdmin",
    "roles/container.viewer",
    "roles/artifactregistry.reader"
)

foreach ($Role in $Roles) {
    gcloud projects add-iam-policy-binding $ProjectId `
        --member "serviceAccount:$ServiceAccountName@$ProjectId.iam.gserviceaccount.com" `
        --role $Role
}

# Generar y descargar la clave JSON
Write-Host "Generando clave JSON para la cuenta de servicio..."
gcloud iam service-accounts keys create $KeyFilePath `
  --iam-account "$ServiceAccountName@$ProjectId.iam.gserviceaccount.com"

# Confirmar el éxito
if (Test-Path $KeyFilePath) {
    Write-Host "Clave JSON generada exitosamente en: $KeyFilePath" -ForegroundColor Green
} else {
    Write-Host "Error al generar la clave JSON." -ForegroundColor Red
}