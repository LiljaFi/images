FROM php:8.3-fpm-bookworm

LABEL author="FalixNodes" maintainer="support@falixnodes.net"

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    ca-certificates \
    nginx \
    supervisor \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mysqli pcntl bcmath zip gd mbstring xml opcache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create container user
RUN useradd -m -d /home/container -s /bin/bash container

# Create directories with proper permissions
RUN mkdir -p /home/container/logs /home/container/public /home/container/tmp \
    && chown -R container:container /home/container

# Copy config files to home directory
COPY --chown=container:container nginx.conf /home/container/nginx.conf
COPY --chown=container:container php-fpm.conf /home/container/php-fpm.conf
COPY --chown=container:container supervisord.conf /home/container/supervisord.conf
COPY --chown=container:container entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container
ENV USER=container HOME=/home/container
ENV COMPOSER_HOME=/home/container/.composer
WORKDIR /home/container

CMD ["/bin/bash", "/entrypoint.sh"]
