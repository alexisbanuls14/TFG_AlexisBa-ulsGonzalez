# Dockerfile

# Usa una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo de dependencias y las instala
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código del proyecto a la imagen
COPY ./app /app/app

# Expone el puerto en el que correrá el servicio
EXPOSE 8000

# Comando para iniciar el servicio
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
