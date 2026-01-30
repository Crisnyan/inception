*This project has been created as part of the 42 curriculum by cmanica-.*

# Inception

## Description
Inception is a System Administration project that aims to deepen knowledge of Docker, Docker Compose, and container orchestration. The goal is to set up a small infrastructure composed of different services running on **Alpine Linux** (version 3.22).

The infrastructure consists of:
* **NGINX** (TLS v1.2/v1.3 only)
* **WordPress** + **php-fpm**
* **MariaDB**
* **Volumes** for data persistence
* **Docker Network** for internal communication

Each service runs in a dedicated container and was built from scratch using custom Dockerfiles.

## Instructions
This repository contains extensive documentation for using and maintaining the project:

* **For Users:** See [USER_DOC.md](./USER_DOC.md) for instructions on how to start the services, access the website, and manage the application.
* **For Developers:** See [DEV_DOC.md](./DEV_DOC.md) for technical details, directory structure, and debugging commands.

To get started immediately:
```bash
make
