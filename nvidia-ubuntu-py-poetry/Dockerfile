FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel
# This one is running on Ubuntu 18.04 using python 3.8

# NVIDIA changed his GPG key !!!!
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    vim \
    build-essential \
    screen \
 && rm -rf /var/lib/apt/lists/*



# Set the default command to python3
CMD ["bash"]