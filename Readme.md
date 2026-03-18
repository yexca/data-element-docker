# Data Element Market Supply-Side Management System - Deployment Center

> **Containerized deployment configurations for the Data Element Market Supply-Side Management System.**

This repository serves as the DevOps hub, providing orchestration for the frontend, backend, database, and search engine services.

## 🔗 Related Repositories

* **Frontend:** [yexca/data-element-frontend](https://github.com/yexca/data-element-frontend)
* **Backend:** [yexca/data-element-backend](https://github.com/yexca/data-element-backend)

## 🛠 Directory Structure

```text
.
├── 📂 plugins/ik/              # (legacy) IK Analyzer (Chinese Segmentation) for Local ES
├── 🐳 docker-compose.yml       # Main Docker Compose orchestration file
├── 📄 es-mapping.json          # (legacy) elasticsearch mapping structure
├── 📄 init.sql                 # Database initialization script (Schema & Data)
└── 📄 Readme.md                # This file
```

## 🚀 Getting Started

### Prerequisites

- Docker & Docker Compose
- **Port Availability:** Port `8999` (Web Portal).
  - *Note: The Backend API port is NOT exposed to the host for security reasons.*
- **Dependencies (optional):**
  - A running Blockchain instance (Fisco Bcos).

------

### Build backend image

For security reasons, please build backend the backend image yourself

**1. Clone the repository:**

```bash
git clone https://github.com/yexca/data-element-backend.git
cd data-element-backend
```

**2. Configure the application:**

Update `data-server/src/main/resources/application.yml` (and `application-prod.yml`) with your own infrastructure settings:

- S3-compatible Object Storage credentials
- (Optional) Enable Fisco Bcos blockchain support and place the related files (abi, bin, conf) into `data-server/src/main/resources`

**3. Build image:**

```bash
docker build -t yexca/data-element:v1.3 .
```

### Run with docker compose

**1. Clone this deployment repository:**

```bash
git clone https://github.com/yexca/data-element-docker.git
cd data-element-docker
```

**2. Start the services:**

```bash
docker compose up -d
```

**3. Access the system:**

- Web Portal: `http://localhost:8999`
- Admin Dashboard: `http://localhost:8999/admin`

## ⚙️ Configuration Details

### 🔐 Network Architecture (Security)

This deployment utilizes **Docker's internal network** for service-to-service communication.

- **Frontend (Nginx):** Exposed on host port `8999`. It acts as a **Reverse Proxy**, forwarding `/api` requests to the backend.
- **Backend (Spring Boot):** Runs on port `8080` *inside* the container network. It is **not exposed** to the public internet, reducing the attack surface.
- **Database:** Accessible only to the backend service within the Docker network.

### Database Initialization

The `init.sql` script is mounted to `/docker-entrypoint-initdb.d/` in the MySQL container. It will automatically:

1. Create the `dataelementai` database.
2. Import initial tables for User, Role, and Data Products.
3. Set up default accounts.

## ❓ Troubleshooting

**Q: Elasticsearch exits with code 137 (OOM)?**  
A: Check your Docker memory settings. Elasticsearch requires at least 2GB of dedicated RAM.
