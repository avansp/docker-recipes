FROM nvidia/cuda:11.4.0-devel-ubuntu18.04
WORKDIR /app

# Setup apt
RUN apt-get update && \
    apt-get install -y software-properties-common vim sudo libsm6 libxext6 libxrender-dev \
    build-essential curl ca-certificates git gcc && \
    rm -rf /var/lib/apt/lists/*

# Upgrade python to 3.10
RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update -y && \
    apt-get install -y python3.8 python3-distutils python3-pip python3-apt && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install pytorch \
RUN pip3 install torch==1.10.2+cu113 torchvision==0.11.3+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html