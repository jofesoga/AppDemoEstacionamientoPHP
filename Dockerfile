# Use a dedicated PHP 5.4 Apache image
FROM php:5.4-apache

# Set labels for OpenShift
LABEL maintainer="your-email@example.com"
LABEL io.openshift.tags="lamp,apache,php5.4,mysql"
LABEL io.openshift.expose-services="8080:http"

# Install necessary PHP extensions for older applications
RUN apt-get update && \
    apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    libmcrypt-dev \
    mysql-client \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib && \
    docker-php-ext-install gd mysql mysqli pdo pdo_mysql mcrypt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Change Apache configuration to use custom ports for OpenShift
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf && \
    sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable Apache modules
RUN a2enmod rewrite

# Create necessary directories and set permissions for OpenShift
RUN mkdir -p /var/run/apache2 && \
    mkdir -p /var/lock/apache2 && \
    chgrp -R 0 /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R g=u /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    chmod -R a+rwx /var/run/apache2

# Set login.php as the default index page
RUN echo "DirectoryIndex login.php index.php index.html index.cgi index.pl index.xhtml index.htm" > /etc/apache2/mods-enabled/dir.conf

# Copy your PHP application code
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 8080
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Apache in foreground
CMD ["apache2-foreground"]