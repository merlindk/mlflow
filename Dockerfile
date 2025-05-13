FROM python:3.10-slim

WORKDIR /app

# Instalar dependencias
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Crear carpetas necesarias
RUN mkdir -p /app/mlruns /app/artifacts

# Exponer puerto de MLflow
EXPOSE 5000

# Comando para iniciar MLflow server
CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000", \
     "--backend-store-uri", "sqlite:///:memory:", \
     "--default-artifact-root", "./artifacts", \
     "--workers", "1"]
