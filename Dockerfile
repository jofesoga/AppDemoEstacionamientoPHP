# Use an older Ubuntu version that supports PHP 5.4
FROM ubuntu:14.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_PID_FILE=/var/run/apache2/apache2.pid \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_LOG_DIR=/var/log/apache2

# Set labels for OpenShift
LABEL maintainer="your-email@example.com"
LABEL io.openshift.tags="lamp,apache,php5.4,mysql"
LABEL io.openshift.expose-services="8080:http"

# Add the old PHP 5.4 repository
RUN apt-get update && \
    apt-get install -y software-properties-python-software-properties && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update

# Install Apache, PHP 5.4, and MySQL client
RUN apt-get install -y \
    apache2 \
    php5 \
    php5-mysql \
    php5-cli \
    php5-json \
    php5-common \
    php5-gd \
    php5-mcrypt \
    php5-curl \
    php5-xml \
    mysql-client \
    curl \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Change Apache configuration to use custom ports for OpenShift
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf && \
    sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable necessary Apache modules and PHP extensions
RUN a2enmod rewrite && \
    php5enmod mcrypt

# Modify Apache environment variables
RUN echo 'export APACHE_RUN_USER=www-data' >> /etc/apache2/envvars && \
    echo 'export APACHE_RUN_GROUP=www-data' >> /etc/apache2/envvars && \
    echo 'export APACHE_PID_FILE=/var/run/apache2/apache2.pid' >> /etc/apache2/envvars && \
    echo 'export APACHE_RUN_DIR=/var/run/apache2' >> /etc/apache2/envvars && \
    echo 'export APACHE_LOCK_DIR=/var/lock/apache2' >> /etc/apache2/envvars && \
    echo 'export APACHE_LOG_DIR=/var/log/apache2' >> /etc/apache2/envvars

# Create necessary directories and set permissions for OpenShift
RUN mkdir -p /var/run/apache2 && \
    mkdir -p /var/lock/apache2 && \
    chgrp -R 0 /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R g=u /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R a+rwx /var/run/apache2

# Set login.php as the default index page (adjust if your app uses a different entry point)
RUN echo "DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm" > /etc/apache2/mods-enabled/dir.conf

# Copy your PHP application code
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 8080 (OpenShift uses random ports, but we need to listen on 8080)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]