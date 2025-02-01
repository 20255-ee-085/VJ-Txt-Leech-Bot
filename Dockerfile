FROM python:3.10.8-slim-buster

# Install system dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    musl-dev \
    python3-dev \
    python3-pip \
    build-essential \
    # Install ffmpeg from official repo
    && apt-get install -y software-properties-common \
    && apt-get install -y ffmpeg \
    # Install aria2 for downloads
    && apt-get install -y aria2 \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app/

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy rest of the code
COPY . .

# Command to run the bot
CMD ["bash", "run_cmd.txt"]
