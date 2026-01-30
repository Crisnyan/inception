DEV_DOC
=
1. Prerequisites

The development environment must be a Debian-based Linux distribution (standard for 42 evaluation) with the following packages installed:

    Docker Engine (v20.10+)

    Docker Compose (v2.0+)

    GNU Make

    OpenSSL (for generating local certificates)

2. Project Architecture

The project follows a modular structure where each service has its own build context and configuration.

inception/
├── Makefile
├── srcs/
│   ├── .env                 # Environment variables (Gitignored)
│   ├── docker-compose.yml   # Orchestration manifest
│   └── requirements/
│       ├── mariadb/         # Config & Dockerfile
│       ├── nginx/           # Config & Dockerfile
│       └── wordpress/       # Config & Dockerfile
└── data/                    # Persistent host volumes

3. Setup & Configuration
Environment Variables (.env)

Create a .env file in srcs/ containing the required secrets. This file is loaded by Docker Compose at runtime. Mandatory Keys:

    MYSQL_ROOT_PASSWORD: Root access for MariaDB.

    MYSQL_USER / MYSQL_PASSWORD: WordPress database credentials.

    DOMAIN_NAME: e.g., login.42.fr.

    WP_ADMIN_USER / WP_ADMIN_PASS: Initial WordPress admin credentials.

Host Configuration
-

Map your domain to the local loopback address in /etc/hosts:

127.0.0.1   login.42.fr

Volume Preparation

By default, Docker volumes are mapped to the host's /home/cmanica-/data directory to ensure data persists.
Bash

# Manual directory creation (if not handled by Makefile)
mkdir -p /home/cmanica-/data/mariadb
mkdir -p /home/cmanica-/data/wordpress

4. Makefile Usage

The Makefile abstracts complex Docker commands to ensure consistency and speed during development.
Target	Technical Action
all	Creates host volume paths, then runs docker-compose up --build -d.
stop	Executes docker-compose stop to halt services.
down	Executes docker-compose down to stop and remove containers/networks.
clean	Removes containers and networks via docker-compose down --rmi all.
fclean	Runs clean and deletes the local data directories (rm -rf /home/cmanica-/data).
5. Docker Compose Deep-Dive

The srcs/docker-compose.yml uses version 3.x syntax. Key developer configurations include:

    Networks: A custom bridge network named inception is used. Containers communicate using service names (e.g., WordPress connects to mariadb:3306).

    Restart Policy: Set to always or unless-stopped to handle service crashes.

    Build Context: Points to the specific requirements/ sub-directory for each service.

6. Data Persistence & Volumes

Data persistence is achieved via Bind Mounts. This allows the developer to inspect database files or WordPress source code directly from the host machine.

    MariaDB Volume: Maps /var/lib/mysql (container) to /home/cmanica-/data/mariadb (host).

    WordPress Volume: Maps /var/www/html (container) to /home/cmanica-/data/wordpress (host).

    Warning: When debugging MariaDB, remember that the initialization scripts in docker-entrypoint-initdb.d only run the first time the volume is created. To re-run them, you must make fclean.
