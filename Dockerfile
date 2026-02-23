# -----------------------------------------------
# 1. IMAGEN BASE
# Usamos Python 3.11 en su versión "slim" (liviana)
# sin herramientas innecesarias del sistema operativo
# -----------------------------------------------
FROM python:3.11-slim

# -----------------------------------------------
# 2. VARIABLES DE ENTORNO
# Evita que Python genere archivos .pyc (bytecode)
# Hace que los print() y errores aparezcan en tiempo real en los logs
# -----------------------------------------------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# -----------------------------------------------
# 3. DIRECTORIO DE TRABAJO
# Todo lo que hagamos a partir de aquí ocurre dentro
# de esta carpeta DENTRO del contenedor
# -----------------------------------------------
WORKDIR /app

# -----------------------------------------------
# 4. COPIAR E INSTALAR DEPENDENCIAS
# Primero copiamos solo el requirements.txt (antes que el código)
# Esto aprovecha el cache de Docker: si requirements.txt no cambia,
# Docker no reinstala las librerías cada vez que reconstruyes
# -----------------------------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------------------------
# 5. COPIAR EL CÓDIGO FUENTE
# Copiamos todo el contenido de nuestra carpeta local
# hacia el WORKDIR (/app) dentro del contenedor
# -----------------------------------------------
COPY . .

# -----------------------------------------------
# 6. PUERTO EXPUESTO
# Le dice a Docker que este contenedor usará el puerto 5000
# (solo es documentativo, el mapeo real se hace en docker-compose)
# -----------------------------------------------
EXPOSE 5000

# -----------------------------------------------
# 7. COMANDO DE INICIO
# Lo que se ejecuta cuando el contenedor arranca
# Corremos la app desde la carpeta app/
# -----------------------------------------------
CMD ["python", "app/app.py"]