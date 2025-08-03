# Use a slim Python base image
FROM python:3.10-slim

# Install git and other system dependencies
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files into the container
COPY . .

# Install the package in development mode to ensure proper module resolution
RUN pip install --no-cache-dir -e .

# Set entrypoint
ENTRYPOINT ["git-sync"]
