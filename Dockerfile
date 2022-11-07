FROM python:3.11-bullseye

# Install basic tools available in apt repo
RUN apt update && \
    apt install -y git git-crypt ca-certificates curl gnupg lsb-release

# Install gomplate
RUN curl -o /usr/local/bin/gomplate \
    -sSL https://github.com/hairyhenderson/gomplate/releases/download/v3.11.3/gomplate_linux-amd64 && \
    chmod +x /usr/local/bin/gomplate

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Install k9s
RUN curl -L https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz | tar xz && \
    mv ./k9s /usr/local/bin && \
    chmod +x /usr/local/bin/k9s && \
    rm ./README.md

# Install kubens and kubectx
RUN curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz | tar xz && \
    curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz | tar xz && \
    mv kubectx /usr/local/bin/ && \
    mv kubens /usr/local/bin/ && \
    chmod +x /usr/local/bin/kubectx && \
    chmod +x /usr/local/bin/kubens

# Install Helm
RUN curl -L https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz | tar xz && \
    mv ./linux-amd64/helm /usr/local/bin/ && \
    chmod +x /usr/local/bin/helm && \
    rm -rf ./linux-amd64

# Install Docker
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update && \
    apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install kind
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# Install Ansible and some collections
RUN pip3 install ansible-core --disable-pip-version-check --root-user-action=ignore && \
    ansible-galaxy collection install kubernetes.core community.general ansible.posix community.docker

# Adding some aliases
RUN echo "alias k=kubectl" >> ~/.bashrc && \
    echo "alias kx=kubectx" >> ~/.bashrc && \
    echo "alias kn=kubens" >> ~/.bashrc

WORKDIR /

ENTRYPOINT ["bash"]