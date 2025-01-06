# Installing and Configuring MariaDB on Ubuntu 22.04

This guide provides comprehensive steps to install, configure, and optionally remove MariaDB from an Ubuntu 22.04 system.

---

## Prerequisites

- A system running Ubuntu 22.04.
  - User with root or sudo privileges.

---

## Steps to Install MariaDB

```bash
sudo systemctl stop mysql
# Ensure the package list is up to date
sudo apt update
# Stop the service, if running
sudo systemctl stop mysql
# Install MariaDB  server and client packages:
sudo apt install -y mariadb-server mariadb-client
# Don't use in Production - ONLY FOR WORKLOAD TESTING
sudo chmod -R 777 /var/run/mysqld
sudo chmod -R 777 /var/lib/mysql
sudo chown -R mysql:mysql /var/lib/mysql/

```

---

### Create a Database and User
```bash
# Log into MariaDB and execute the following commands
CREATE DATABASE mydatabase;
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON mydatabase.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;
```

---

## Steps to Completely Remove MariaDB

```bash
# Stop the MariaDB Service
sudo systemctl stop mysql
# Uninstall MariaDB Packages
sudo apt remove --purge -y mariadb-server
sudo apt remove --purge -y mariadb-client
sudo apt autoremove --purge -y
# Delete Configuration and Data Files
sudo rm -rf /etc/mysql /var/lib/mysql /var/lib/mysql-files /var/log/mysql /var/log/mariadb /var/cache/mysql 
```