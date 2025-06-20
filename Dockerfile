FROM python:3.12.3-slim

# Install OS dependencies including netcat
RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxrender1 libxext6 libgl1-mesa-glx \
    netcat-openbsd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy scripts and assets
COPY server.py client.py test_image.jpeg wait-for-it.sh .
RUN chmod +x wait-for-it.sh

# Default to running the server unless overridden in docker-compose
CMD ["python", "server.py"]
