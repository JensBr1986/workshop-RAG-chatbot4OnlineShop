# Basis-Image mit Python 3.13
FROM python:3.13-slim

# Arbeitsverzeichnis setzen
WORKDIR /app

# Systemabhängigkeiten (optional, falls z.B. chromadb oder gradio native libs brauchen)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Repo klonen
# RUN git clone https://github.com/magnusse/workshop-RAG-chatbot4OnlineShop.git src
COPY ./requirements.txt /app/src/requirements.txt

WORKDIR /app/src

# Python-Abhängigkeiten installieren
RUN pip install --no-cache-dir -r requirements.txt

# Default Command
# Port für Gradio (Standard 7860)
EXPOSE 7860

# Argumente/Umgebungsvariablen für Sprint/Variante
ARG START_SCRIPT=ragshop/SalesConsultant/UseInterface.py
ENV START_SCRIPT=${START_SCRIPT}

# PYTHONPATH setzen, damit /app/src als Modulpfad gilt
ENV PYTHONPATH=/app/src

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]