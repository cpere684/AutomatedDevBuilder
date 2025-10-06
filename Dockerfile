# Base image for development environment
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANSIBLE_HOST_KEY_CHECKING=False

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ansible \
    sudo \
    curl \
    wget \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for development
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Copy Ansible playbooks and configurations
COPY ansible/ /ansible/
WORKDIR /ansible

# Set the default user
USER $USERNAME
WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
