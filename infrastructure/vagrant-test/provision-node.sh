#!/bin/sh

# Configure SSH Daemon
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && systemctl restart sshd

# Install Ansible
sudo apt update && sudo apt install ansible git -y

# Clone repo
sudo git clone "https://github.com/windowsagent/devops-rampup/" /root/devops-rampup/

# Run ansible playbook to setup k8s
ansible-playbook /root/devops-rampup/infrastructure/ansible/setup_k3s.yml
