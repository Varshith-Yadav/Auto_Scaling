# 🚀 Auto-Scaling DevOps Platform on GCP

A comprehensive DevOps solution that deploys an auto-scaling NGINX application on Google Kubernetes Engine (GKE) with complete CI/CD pipeline, infrastructure as code, and monitoring capabilities.

## 🔍 Overview

This platform demonstrates a production-ready DevOps implementation that leverages infrastructure as code, containerization, orchestration, configuration management, and continuous integration/deployment to create a fully automated, scalable application environment on Google Cloud Platform.

![image](https://github.com/user-attachments/assets/abe1c066-4b03-46f0-beb6-64f7937f2510)


## 🧱 Technology Stack

- **Web Server:** NGINX containerized application
- **Containerization:** Docker
- **Orchestration:** Kubernetes (GKE)
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **CI/CD Pipeline:** Jenkins
- **Monitoring & Observability:** Prometheus & Grafana
- **Cloud Provider:** Google Cloud Platform (GCP)

## ✨ Key Features

- **Automated Infrastructure Provisioning**: Complete GCP infrastructure defined and managed through Terraform
- **Dynamic Auto-Scaling**: Horizontal Pod Autoscaler (HPA) that adjusts application resources based on actual load
- **Containerized Deployment**: Dockerized NGINX application for consistent deployment across environments
- **Continuous Integration/Deployment**: Jenkins pipeline for automated testing and deployment
- **Configuration Management**: Ansible for consistent system configuration and tool installation
- **Real-time Monitoring**: Prometheus metrics collection with Grafana dashboards
- **High Availability**: Multi-zone GKE cluster deployment for resilience
- **Infrastructure Security**: Secure network configuration and access controls

## 📁 Project Structure

```
nginx-autoscale-platform/
│
├── Dockerfile                    # NGINX container definition
├── Jenkinsfile                   # CI/CD pipeline configuration
├── README.md                     # Project documentation
│
├── ansible/
│   ├── install_tools.yml         # Tools installation playbook
│   └── inventory.ini             # Target hosts inventory
│
├── terraform/
│   ├── main.tf                   # GCP infrastructure definition
│   ├── variables.tf              # Configurable parameters
│   ├── outputs.tf                # Infrastructure outputs
│   └── provider.tf               # Provider configuration
│
├── k8s/
│   ├── deployment.yaml           # NGINX application deployment
│   ├── service.yaml              # Service definition for NGINX
│   ├── hpa.yaml                  # Horizontal Pod Autoscaler configuration
│   └── ingress.yaml              # Ingress configuration
│
└── monitoring/
    ├── prometheus-values.yaml    # Prometheus Helm values
    └── grafana-values.yaml       # Grafana Helm values
```

## 🚀 Getting Started

### Prerequisites

- Google Cloud Platform account
- GCP project with billing enabled
- Local installation of:
  - Terraform (v1.0+)
  - Ansible (v2.9+)
  - Docker (v20.10+)
  - kubectl (latest)
  - gcloud CLI (latest)

### Deployment Steps

1. **Initialize GCP authentication:**
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

2. **Deploy infrastructure with Terraform:**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

3. **Configure environment with Ansible:**
   ```bash
   cd ../ansible
   ansible-playbook -i inventory.ini install_tools.yml
   ```

4. **Deploy to Kubernetes:**
   ```bash
   cd ../k8s
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f hpa.yaml
   ```

5. **Set up monitoring:**
   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm install prometheus prometheus-community/prometheus -f monitoring/prometheus-values.yaml
   helm install grafana grafana/grafana -f monitoring/grafana-values.yaml
   ```

## 📈 Auto-Scaling Configuration

The platform uses Kubernetes Horizontal Pod Autoscaler (HPA) to automatically scale the NGINX application based on CPU and memory utilization:

- **Scale Out Trigger:** When CPU utilization exceeds 70% of requested resources
- **Scale In Stabilization:** 5-minute cool-down period to prevent thrashing
- **Min/Max Replicas:** Configurable minimum and maximum pod counts (default: 2-10)
- **Custom Metrics:** Optional scaling based on request rate or other application metrics

The HPA continuously monitors application metrics and adjusts the replica count accordingly, ensuring optimal resource utilization while maintaining performance under varying loads.

## 🔄 CI/CD Pipeline

The Jenkins pipeline automates:

1. Code checkout from repository
2. Docker image building and testing
3. Image publishing to Container Registry
4. Kubernetes deployment updates
5. Post-deployment testing

## 📊 Monitoring

Access the monitoring stack:

- **Prometheus:** For metrics collection and storage
- **Grafana:** For visualization with pre-configured dashboards to monitor:
  - Container resource utilization
  - NGINX performance metrics
  - Auto-scaling events
  - Request latency and throughput

## 📝 License

[MIT License](LICENSE)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
