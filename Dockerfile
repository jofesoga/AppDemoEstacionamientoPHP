# Use Ubuntu 14.04 which has PHP 5.4 in its repositories
FROM ubuntu:14.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set labels for OpenShift
LABEL maintainer="your-email@example.com"
LABEL io.openshift.tags="lamp,apache,php5.4,mysql"
LABEL io.openshift.expose-services="8080:http"

# Update package lists from archive repositories
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list

# Install Apache, PHP 5.4, and MySQL client
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php5 \
    php5-mysql \
    php5-cli \
    php5-json \
    php5-common \
    php5-gd \
    php5-mcrypt \
    php5-curl \
    mysql-client \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Completely replace ports.conf to use only port 8080
RUN echo "Listen 8080" > /etc/apache2/ports.conf && \
    echo "<IfModule ssl_module>" >> /etc/apache2/ports.conf && \
    echo "    Listen 443" >> /etc/apache2/ports.conf && \
    echo "</IfModule>" >> /etc/apache2/ports.conf && \
    echo "<IfModule mod_gnutls.c>" >> /etc/apache2/ports.conf && \
    echo "    Listen 443" >> /etc/apache2/ports.conf && \
    echo "</IfModule>" >> /etc/apache2/ports.conf

# Update default virtual host to use port 8080
RUN sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's/:80>/:8080>/' /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Update Apache environment variables
RUN echo "export APACHE_RUN_USER=www-data" > /etc/apache2/envvars && \
    echo "export APACHE_RUN_GROUP=www-data" >> /etc/apache2/envvars && \
    echo "export APACHE_PID_FILE=/var/run/apache2/apache2.pid" >> /etc/apache2/envvars && \
    echo "export APACHE_RUN_DIR=/var/run/apache2" >> /etc/apache2/envvars && \
    echo "export APACHE_LOCK_DIR=/var/lock/apache2" >> /etc/apache2/envvars && \
    echo "export APACHE_LOG_DIR=/var/log/apache2" >> /etc/apache2/envvars && \
    echo "export APACHE_RUN_PORT=8080" >> /etc/apache2/envvars

# Enable necessary Apache modules
RUN a2enmod rewrite

# Set login.php as the default index page
RUN echo "DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm" > /etc/apache2/mods-enabled/dir.conf

# Copy your PHP application code
COPY src/ /var/www/html/

# Create necessary directories
RUN mkdir -p /var/run/apache2 && \
    mkdir -p /var/lock/apache2

# Set proper permissions for OpenShift
RUN chgrp -R 0 /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R g=u /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R a+rwx /var/run/apache2 && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 8080
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Apache directly on port 8080
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]