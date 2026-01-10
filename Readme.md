# Data Element Market Supply-Side Management System - Deployment Center

> **Containerized deployment configurations for the Data Element Market Supply-Side Management System.**

This repository serves as the DevOps hub, providing orchestration for the frontend, backend, database, and search engine services.

## 🔗 Related Repositories

* **Frontend:** [data-element-frontend](https://github.com/yexca/data-element-frontend)
* **Backend:** [data-element-backend](https://github.com/yexca/data-element-backend)

## 📂 Deployment Strategies

To address performance bottlenecks and resource constraints, this system supports two deployment architectures.

| Feature | **Mode A: Standalone (Legacy)** | **Mode B: Distributed (Recommended)** |
| :--- | :--- | :--- |
| **Config File** | `docker-compose-es.yml` | `docker-compose.yml` |
| **App Version** | `v1.1` | `v1.2` (Latest) |
| **Elasticsearch** | **Runs inside Docker** (Local) | **External Server** (Remote) |
| **Use Case** | Demo / Testing on powerful machines | Production / Cloud Deployment / Low-spec servers |
| **Memory Req** | > 4GB RAM | < 1GB RAM |

## 🛠 Directory Structure

```text
.
├── 📂 plugins/ik/              # IK Analyzer (Chinese Segmentation) for Local ES
├── 🐳 docker-compose-es.yml    # [Mode A] Full Stack including Elasticsearch (v1.1)
├── 🐳 docker-compose.yml       # [Mode B] Lightweight App + MySQL (v1.2)
├── 📄 init.sql                 # Database initialization script (Schema & Data)
└── 📄 Readme.md                # This file
```

## 🚀 Getting Started

### Prerequisites

### Prerequisites

- Docker & Docker Compose
- **Port Availability:** Port `8999` (Web Portal).
  - *Note: The Backend API port is NOT exposed to the host for security reasons.*
- **Dependencies:**
  - A running Blockchain instance (Fisco Bcos).
  - (For Mode B) A running external Elasticsearch instance.

------

### Option 1: Distributed Deployment (Recommended)

**Use this for the latest version (v1.2).** This mode runs the application and database locally but expects Elasticsearch to be running on an external server (configured via `data.elastic-search.server`).

```Bash
# Start MySQL and App (v1.2)
docker-compose up -d
```

> **Note:** Ensure your external Elasticsearch server is accessible and the backend configuration points to the correct IP.

------

### Option 2: Standalone Deployment (Full Stack)

**Use this for a self-contained demo (v1.1).** This mode spins up the entire stack, including a local Elasticsearch container with IK Analyzer mounted.

```Bash
# Start MySQL, Local ES, and App (v1.1)
docker-compose -f docker-compose-es.yml up -d
```

> **Warning:** Elasticsearch requires significant memory. If the container exits with code 137, please increase your Docker memory limit.

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

### Elasticsearch Plugins (Mode A only)

The `docker-compose-es.yml` configuration mounts the local `./plugins` directory to the Elasticsearch container:

```YAML
volumes:
  - ./plugins:/usr/share/elasticsearch/plugins
```

This ensures the **IK Analyzer** (smart Chinese tokenization) is loaded without needing to rebuild the ES image.

## ❓ Troubleshooting

**Q: I cannot access the backend API at localhost:8080?** A: This is intentional. Please access the API through the frontend proxy at `http://localhost:8999/api`.

**Q: Elasticsearch exits with code 137 (OOM)?** A: Check your Docker memory settings. Elasticsearch requires at least 2GB of dedicated RAM.
