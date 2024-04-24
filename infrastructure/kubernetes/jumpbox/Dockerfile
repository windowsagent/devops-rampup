FROM alpine:latest

# Install tools
ENV TERRAFORM_VERSION=1.8.1
RUN apk add git ansible neovim curl unzip

# Install kubectl (for k3s)
RUN curl -LO https://github.com/k3s-io/k3s/releases/download/v1.29.3%2Bk3s1/k3s \
    && chmod +x k3s \
    && mv k3s /usr/local/bin/k3s \
    && alias kubectl="k3s kubectl"

# Install terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Clone repo
RUN git clone https://github.com/windowsagent/devops-rampup /root/devops-rampup

# Install SSH, disable password authentication
RUN apk add openssh \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_conf

EXPOSE 22
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
