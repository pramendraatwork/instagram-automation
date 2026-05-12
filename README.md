
# Instagram DM Automation — DevOps Pipeline

An event-driven Instagram comment-to-DM automation platform with a complete production-grade DevOps pipeline.

## Project Overview
When a user comments a keyword (e.g. "link") on an Instagram post, the system automatically detects it via webhook and sends a DM with the requested information.

## Architecture
Instagram Comment → Meta Webhook → ngrok → n8n Workflow → IF (keyword check) → Instagram DM
## Tech Stack
| Category | Technology |
|----------|-----------|
| Automation | n8n workflow engine |
| Containerization | Docker + Docker Compose |
| CI/CD | GitHub Actions |
| Infrastructure as Code | Terraform |
| Cloud | AWS EC2 (ap-south-1) |
| Monitoring | Prometheus + Grafana |
| Tunnel | ngrok |
| API | Meta Graph API v25.0 |

## Project Structure
instagram-automation/
├── docker-compose.yml      # n8n + Prometheus + Grafana
├── terraform/
│   └── main.tf            # AWS EC2 infrastructure
├── .github/
│   └── workflows/
│       └── deploy.yml     # CI/CD pipeline
└── README.md

## Setup Instructions

### 1. Prerequisites
- Node.js v20+
- Docker + Docker Compose
- ngrok account
- Meta Developer account
- AWS account

### 2. Local Setup
```bash
git clone https://github.com/pramendraatwork/instagram-automation
cd instagram-automation
docker-compose up -d
```

### 3. AWS Deployment
```bash
cd terraform
terraform init
terraform apply
```

### 4. Configure Meta Webhook
- Callback URL: `https://your-ngrok-url/webhook/instagram`
- Verify Token: your secret token
- Subscribe to: comments, messages

## CI/CD Pipeline
Every push to `main` branch triggers GitHub Actions workflow that automatically deploys to AWS EC2.

## Monitoring
- Prometheus: `http://server-ip:9090`
- Grafana: `http://server-ip:3000`
## Monitoring Dashboard
![Grafana Dashboard](grafana-dashboard.png)
## Note on DM Sending
The Instagram DM sending feature requires Meta app review approval for `instagram_manage_messages` permission. The webhook detection, keyword filtering, and DevOps infrastructure are fully functional.

## Author
Pramendra Rajpoot — [LinkedIn](https://www.linkedin.com/in/pramendra-rajpoot-0518803b0/) | [GitHub](https://github.com/pramendraatwork)
