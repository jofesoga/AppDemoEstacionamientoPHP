# Use Ubuntu base image
FROM ubuntu:22.04

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
LABEL io.openshift.tags="lamp,apache,php,mysql"
LABEL io.openshift.expose-services="8080:http"

# Install Apache, PHP, MySQL client and other necessary packages
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php@5.4.0 \
    php-mysql \
    php-cli \
    php-json \
    php-common \
    php-zip \
    php-gd \
    php-mbstring \
    php-curl \
    php-xml \
    php-bcmath \
    php-intl \
    php-soap \
    mariadb-client \
    curl \
    wget \
	vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the startup script
COPY start-apache.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-apache.sh

# Change Apache configuration to use custom ports for OpenShift
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf && \
    sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

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

# Copy a simple PHP info script for testing and your app source code
COPY index.php /var/www/html/
RUN chown www-data:www-data /var/www/html/index.php && \
    chmod g+rw /var/www/html/index.php
COPY ingresa.php /var/www/html/
RUN chown www-data:www-data /var/www/html/ingresa.php && \
    chmod g+rw /var/www/html/ingresa.php
COPY cerrarcaja.php /var/www/html/
RUN chown www-data:www-data /var/www/html/cerrarcaja.php && \
    chmod g+rw /var/www/html/cerrarcaja.php
COPY cierre.php /var/www/html/
RUN chown www-data:www-data /var/www/html/cierre.php && \
    chmod g+rw /var/www/html/cierre.php	
COPY close.php /var/www/html/
RUN chown www-data:www-data /var/www/html/close.php && \
    chmod g+rw /var/www/html/close.php
COPY ingreso.php /var/www/html/
RUN chown www-data:www-data /var/www/html/ingreso.php && \
    chmod g+rw /var/www/html/ingreso.php
COPY menu.php /var/www/html/
RUN chown www-data:www-data /var/www/html/menu.php && \
    chmod g+rw /var/www/html/menu.php
COPY prueba.php /var/www/html/
RUN chown www-data:www-data /var/www/html/prueba.php && \
    chmod g+rw /var/www/html/prueba.php
COPY Reporte.php /var/www/html/
RUN chown www-data:www-data /var/www/html/Reporte.php && \
    chmod g+rw /var/www/html/Reporte.php
COPY salevehiculo.php /var/www/html/
RUN chown www-data:www-data /var/www/html/salevehiculo.php && \
    chmod g+rw /var/www/html/salevehiculo.php
COPY salida.html /var/www/html/
RUN chown www-data:www-data /var/www/html/salida.html && \
    chmod g+rw /var/www/html/salida.html
COPY salida.php /var/www/html/
RUN chown www-data:www-data /var/www/html/salida.php && \
    chmod g+rw /var/www/html/salida.php
COPY script.html /var/www/html/
RUN chown www-data:www-data /var/www/html/script.html && \
    chmod g+rw /var/www/html/script.html
COPY sesion.php /var/www/html/
RUN chown www-data:www-data /var/www/html/sesion.php && \
    chmod g+rw /var/www/html/sesion.php

# Expose port 8080 (OpenShift uses random ports, but we need to listen on 8080)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Apache in foreground
CMD ["/usr/local/bin/start-apache.sh"]