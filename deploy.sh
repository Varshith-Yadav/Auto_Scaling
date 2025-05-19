#!/bin/bash
set -e

# Step 1: Deploy GKE Infrastructure with Terraform
echo "Deploying GKE infrastructure with Terraform..."
cd terraform
terraform init
terraform apply -auto-approve
cd ..

# Step 2: Configure kubectl
echo "Configuring kubectl..."
gcloud container clusters get-credentials auto-scaling-platform --zone us-central1-a --project your-project-id

# Step 3: Set up Kubernetes resources
echo "Creating Kubernetes resources..."
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/resource-quotas.yaml
kubectl apply -f kubernetes/deployments/sample-app.yaml
kubectl apply -f kubernetes/deployments/hpa.yaml

# Step 4: Set up monitoring
echo "Setting up monitoring..."
cd monitoring
bash setup-monitoring.sh
cd ..

# Step 5: Deploy Jenkins
echo "Deploying Jenkins..."
kubectl apply -f jenkins/jenkins-deployment.yaml

# Step 6: Configure supporting infrastructure with Ansible
echo "Configuring supporting infrastructure with Ansible..."
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/setup-database.yml
ansible-playbook -i inventory/hosts.ini playbooks/configure-backups.yml
cd ..

echo "Auto-scaling platform deployment complete!"
echo "Jenkins is available at: $(kubectl get svc jenkins -n jenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):8080"
echo "Grafana is available at: $(kubectl get svc grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):80"