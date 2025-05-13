FROM python:3.10-slim

# Crear y usar un directorio seguro como directorio de trabajo
RUN useradd -ms /bin/bash mlflowuser
RUN mkdir -p /mlflow/mlruns /mlflow/artifacts && chmod -R 777 /mlflow
WORKDIR /mlflow

# Instalar dependencias
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

USER mlflowuser

# Exponer puerto de MLflow
EXPOSE 5000

# Comando para iniciar MLflow server
CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000", \
     "--backend-store-uri", "sqlite:///:memory:", \
     "--default-artifact-root", "./artifacts", \
     "--workers", "1"]
