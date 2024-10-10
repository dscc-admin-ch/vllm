FROM python:3.9-slim

# Set environment variables
ENV VLLM_TARGET_DEVICE=cpu

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y gcc-12 g++-12 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

# Upgrade pip and install required Python packages
RUN pip install --upgrade pip && \
    pip install wheel packaging ninja "setuptools>=49.4.0" numpy

# Copy the rest of the application into the container
COPY ./vllm ./vllm

WORKDIR ./vllm

# Install dependencies and build 
RUN pip install -v -r requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu
RUN python setup.py install

# Expose webserver on port 8000
EXPOSE 8000

# Run OpenAI-compatible webserver
CMD ["python", "vllm/entrypoints/openai/api_server.py"]
