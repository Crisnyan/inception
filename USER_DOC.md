USER_DOC

This documentation provides essential instructions for administrators and end-users to operate the Inception infrastructure. It covers starting the stack, accessing the services, and performing basic maintenance.
1. Initial Setup
Prerequisites
-

Before running the system, ensure the following are prepared:

    Docker & Docker Compose must be installed on the host machine.

    Make must be available.

Network Configuration
-

To access the website via the required domain name, you must configure your host machine's local DNS.

    Open your hosts file (/etc/hosts on Linux/Mac or C:\Windows\System32\drivers\etc\hosts on Windows).

    Add the following line:

    127.0.0.1   login.42.fr

    (Replace login with your specific username if required).

Credentials Management
-

The system relies on environment variables for security.

    Navigate to the srcs/ directory.

    Ensure a .env file exists.

    Important: This file contains sensitive credentials, including:

        Database Root Password (MYSQL_ROOT_PASSWORD)

        WordPress Admin User/Pass (WP_ADMIN_USER, WP_ADMIN_PASSWORD)

        Database User/Pass (MYSQL_USER, MYSQL_PASSWORD)
2. Operation: Starting and Stopping

The infrastructure is controlled via a Makefile located in the root directory.
Command	Description	Usage
Start Stack	Builds images and starts all containers in the background.	make
Stop Stack	Pauses the containers without removing them.	make stop
Shutdown	Stops containers and removes network interfaces.	make down
Reset	Full restart: stops, removes, and rebuilds the stack.	make re
Deep Clean	WARNING: Stops the stack and deletes all persistent data (database & site files).	make fclean
3. Accessing the Application

Once the stack is running (verify with docker ps), you can access the services via a web browser.
The Website (WordPress)

    URL: https://login.42.fr

    Security Warning: You will encounter a browser warning stating "Your connection is not private" or "Potential Security Risk".

        Reason: The SSL certificate is self-signed for development purposes.

        Action: Click Advanced -> Proceed to login.42.fr (unsafe) to access the site.

The Admin Panel
-

    URL: https://login.42.fr/wp-admin

    Login: Use the credentials defined in the .env file (WP_ADMIN_USER / WP_ADMIN_PASSWORD).

4. Basic Checks & Troubleshooting

If the website is not loading, use these commands to diagnose the issue.

Ensure all three core containers (nginx, mariadb, wordpress) are up.

docker ps

Expected Output: Status should be Up (healthy) or simply Up.
2. View Service Logs

If a specific service is crashing (e.g., mariadb), check its logs for error messages.

docker-compose -f srcs/docker-compose.yml logs mariadb
docker-compose -f srcs/docker-compose.yml logs nginx
docker-compose -f srcs/docker-compose.yml logs wordpress

3. Verify Data Persistence

To ensure your data is safe:

    Create a post on WordPress.

    Run make down.

    Run make.

    Check if the post still exists. If it vanishes, check the volume mappings in docker-compose.yml.
