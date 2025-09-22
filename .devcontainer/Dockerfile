# Simple Debian-based builder for Sympa from source
FROM debian:stable-slim

# System deps (trim as needed)
RUN apt-get update && apt-get install -y \
    build-essential \
    perl \
    libperl-dev \
    libdbi-perl libdbd-mysql-perl \
    libxml-libxml-perl libxml-parser-perl \
    libsoap-lite-perl \
    libfcgi-perl \
    libio-socket-ssl-perl \
    libdigest-sha-perl \
    libmariadb-dev-compat \
    mariadb-client \
    curl ca-certificates git \
    apache2 libapache2-mod-fcgid \
    && rm -rf /var/lib/apt/lists/*

# Copy your fork into the image (assumes Docker build context is the repo)
WORKDIR /opt/sympa
COPY . /opt/sympa

# Install Sympa (adjust if your repo uses a different installer)
# Typical: ./configure && make && make install, or a vendor script
# If your fork has a Makefile.PL/Build.PL, adjust accordingly.
RUN if [ -f configure ]; then \
      ./configure --with-user=sympa --with-group=sympa --with-apache=/usr/sbin/apache2; \
      make && make install; \
    else \
      echo "No configure script found—adjust Dockerfile to your build steps" && exit 1; \
    fi

# Minimal runtime setup
RUN useradd -r -s /usr/sbin/nologin sympa || true \
 && mkdir -p /var/spool/sympa /var/log/sympa /etc/sympa \
 && chown -R sympa:sympa /var/spool/sympa /var/log/sympa /etc/sympa

# Apache FastCGI for wwsympa (simple demo)
RUN a2enmod fcgid && \
    printf '%s\n' \
    'ServerName localhost' \
    '<VirtualHost *:8080>' \
    '  ServerAdmin admin@example.test' \
    '  DocumentRoot /usr/local/sympa' \
    '  ScriptAlias /wws /usr/local/sympa/bin/wwsympa.fcgi' \
    '  <Directory /usr/local/sympa/bin>' \
    '    Options +ExecCGI' \
    '    Require all granted' \
    '  </Directory>' \
    '</VirtualHost>' \
    > /etc/apache2/sites-available/sympa.conf && \
    a2ensite sympa

EXPOSE 8080
CMD ["bash", "-lc", "apachectl -DFOREGROUND"]
