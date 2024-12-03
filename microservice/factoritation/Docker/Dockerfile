# Usar una imagen base de Python
FROM python:3.9-slim

# Configurar el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto
COPY app.py /app

# Instalar las dependencias necesarias
RUN pip install Flask

# Exponer el puerto que usará el servicio
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
