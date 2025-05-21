# 🚀 Auto-Scaling DevOps Platform on GCP (NGINX + K8s + Jenkins + Terraform + Ansible)

This project demonstrates a full-scale DevOps pipeline using cutting-edge tools to deploy an NGINX application on GKE with auto-scaling, monitoring, and CI/CD automation.

## 🧱 Stack Used

- **Frontend/Backend:** NGINX containerized app
- **Containerization:** Docker
- **Orchestration:** Kubernetes (GKE)
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **CI/CD:** Jenkins
- **Monitoring:** Prometheus & Grafana (via Helm)

---

## 📁 Project Structure

nginx-autoscale-platform/
│
├── Dockerfile
├── Jenkinsfile
├── ansible/
│ └── install_tools.yml
├── terraform/
│ ├── main.tf
│ └── variables.tf
├── k8s/
│ ├── deployment.yaml
│ ├── service.yaml
│ └── hpa.yaml

yaml
Copy
Edit



📌 Key Features
⚙️ End-to-end automated deployment

📈 Real-time monitoring with Prometheus + Grafana

📦 Auto-scaling with Horizontal Pod Autoscaler (HPA)

🔐 Modular infrastructure using Terraform & Ansible

🚀 CI/CD pipeline using Jenkins