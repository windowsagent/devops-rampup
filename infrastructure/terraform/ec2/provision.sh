#!/bin/sh

# Install Ansible and git
sudo apt update
sudo apt install ansible git -y

# Clone repo
sudo git clone "https://github.com/windowsagent/devops-rampup/" /root/devops-rampup/

# Run ansible playbook to setup k8s
ansible-playbook /root/devops-rampup/infrastructure/ansible/setup_k3s.yml

# Run ansible playbook to setup DB
ansible-playbook /root/devops-rampup/infrastructure/ansible/setup_db.yml --extra-vars "RDS_ENDPOINT=${rds_endpoint}"