# Auto-Scaling Platform Project

A comprehensive DevOps project that implements a fully auto-scaling platform using Docker, Kubernetes, GKE, Terraform, Jenkins, and Ansible.

## Overview

This project demonstrates how to create a production-grade auto-scaling platform that can dynamically adjust to workload demands. The solution includes:

- Infrastructure as Code with Terraform for GKE cluster provisioning
- Kubernetes configuration with auto-scaling capabilities
- Monitoring stack with Prometheus and Grafana
- CI/CD pipeline with Jenkins
- Configuration management with Ansible

## Architecture

The platform implements the following architecture:

- **Infrastructure Layer**: Google Cloud Platform with GKE
- **Container Orchestration**: Kubernetes with Horizontal Pod Autoscaler
- **CI/CD**: Jenkins for automated deployments
- **Monitoring**: Prometheus and Grafana
- **Configuration Management**: Ansible

## Prerequisites

- Google Cloud Platform account with billing enabled
- `gcloud` CLI installed and configured
- `terraform` CLI (v1.0.0+)
- `kubectl` CLI
- `helm` CLI (v3+)
- `ansible` CLI
- Docker installed

## Project Structure

```
auto-scaling-platform/
├── terraform/                      # Terraform configuration for infrastructure
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── modules/
│       ├── gke/                    # GKE cluster configuration
│       └── networking/             # VPC network configuration
├── kubernetes/                     # Kubernetes manifests
│   ├── namespace.yaml
│   ├── resource-quotas.yaml
│   ├── deployments/
│   │   ├── sample-app.yaml         # Sample application deployment
│   │   └── hpa.yaml                # Horizontal Pod Autoscaler configuration
│   └── services/
├── monitoring/                     # Monitoring configuration
│   ├── prometheus/
│   │   └── prometheus-values.yaml
│   ├── grafana/
│   │   └── grafana-values.yaml
│   └── setup-monitoring.sh
├── jenkins/                        # Jenkins CI/CD configuration
│   ├── jenkins-deployment.yaml
│   └── Jenkinsfile
├── ansible/                        # Ansible configuration
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbooks/
│   │   ├── setup-database.yml
│   │   └── configure-backups.yml
│   └── roles/
│       ├── common/
│       ├── database/
│       └── backups/
└── deploy.sh                       # Main deployment script
```

## Deployment Steps

### 1. Infrastructure Deployment

Deploy the GKE infrastructure using Terraform:

```bash
cd terraform
terraform init
terraform apply
```

This will create:
- VPC network and subnet
- NAT gateway for outbound traffic
- GKE cluster with auto-scaling node pools

### 2. Kubernetes Configuration

Apply the Kubernetes configurations:

```bash
# Configure kubectl
gcloud container clusters get-credentials auto-scaling-platform --zone us-central1-a --project your-project-id

# Apply Kubernetes manifests
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/resource-quotas.yaml
kubectl apply -f kubernetes/deployments/sample-app.yaml
kubectl apply -f kubernetes/deployments/hpa.yaml
```

### 3. Monitoring Setup

Set up Prometheus and Grafana for monitoring:

```bash
cd monitoring
bash setup-monitoring.sh
```

Access Grafana:
- Get the password: `kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode`
- Access the UI: `http://<EXTERNAL-IP>:80`

### 4. Jenkins Deployment

Deploy Jenkins for CI/CD:

```bash
kubectl apply -f jenkins/jenkins-deployment.yaml

# Get Jenkins admin password
kubectl exec -it $(kubectl get pods -n jenkins -l app=jenkins -o jsonpath='{.items[0].metadata.name}') -n jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword
```

Access Jenkins:
- Access the UI: `http://<EXTERNAL-IP>:8080`

### 5. Configure Supporting Infrastructure with Ansible

Configure database and backup servers:

```bash
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/setup-database.yml
ansible-playbook -i inventory/hosts.ini playbooks/configure-backups.yml
```

### 6. Full Deployment

To deploy everything at once:

```bash
./deploy.sh
```

## Auto-Scaling Features

### Horizontal Pod Autoscaler (HPA)

The platform includes HPA configured to scale based on:
- CPU utilization (70%)
- Memory utilization (80%)

Configuration:
- Minimum replicas: 2
- Maximum replicas: 10
- Scale-down stabilization window: 300 seconds
- Scale-up stabilization window: 60 seconds

### Cluster Autoscaler

Node pools are configured to auto-scale based on pod resource requirements:
- General pool: 1-5 nodes
- High-CPU pool: 0-3 nodes

## Testing Auto-Scaling

To test the auto-scaling capabilities:

1. Generate load:
```bash
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://sample-app; done"
```

2. Monitor HPA scaling:
```bash
kubectl get hpa -n app -w
```

3. Monitor node scaling:
```bash
kubectl get nodes -w
```

## CI/CD Pipeline

The Jenkins pipeline (`Jenkinsfile`) includes:
1. Building and pushing a Docker image
2. Deploying to Kubernetes
3. Verifying deployment success

## Monitoring

The monitoring setup includes:
- Prometheus for metrics collection
- Grafana dashboards for visualization:
  - Kubernetes cluster overview
  - Node metrics
  - Pod resource utilization
  - HPA metrics

## Maintenance

### Scaling Considerations
- Adjust HPA settings based on real-world application performance
- Tune node pool sizes based on workload patterns

### Backup Strategy
- Database backups are scheduled daily
- Retention period: 7 days

## Troubleshooting

Common issues and solutions:

1. **HPA not scaling pods**
   - Check metrics availability: `kubectl describe hpa -n app`
   - Verify resource requests are properly set in deployment

2. **Nodes not scaling**
   - Check GKE Cluster Autoscaler logs
   - Verify node resource utilization

3. **Jenkins pipeline failures**
   - Check pod logs: `kubectl logs <jenkins-pod-name> -n jenkins`
   - Verify service account permissions

## Security Considerations

The platform implements several security best practices:
- Least privilege service accounts
- Network policy enforcement
- Workload Identity for GCP resource access
- Private GKE cluster with NAT gateway

## Cost Optimization

To optimize costs:
- Use preemptible VMs for non-critical workloads
- Set appropriate auto-scaling thresholds
- Implement proper resource requests and limits

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT
