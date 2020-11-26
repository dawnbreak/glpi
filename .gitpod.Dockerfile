FROM gitpod/workspace-mysql

# Install custom tools, runtimes, etc.
#
# More information: https://www.gitpod.io/docs/config-docker/

# install GLPI requirememts
RUN sudo apt-get update -q \
    && sudo apt-get install -y php-dev php-apcu php-xmlrpc php-bz2 php-ldap \
    && sudo rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*

RUN wget http://xdebug.org/files/xdebug-2.9.1.tgz \
    && tar -xvzf xdebug-2.9.1.tgz \
    && cd xdebug-2.9.1 \
    && phpize \
    && ./configure \
    && make \
    && sudo mkdir -p /usr/lib/php/20190902 \
    && sudo cp modules/xdebug.so /usr/lib/php/20190902 \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.remote_enable = 1\nxdebug.remote_autostart = 1\n' >> /etc/php/7.4/cli/php.ini"

# change document root folder. It's relative to your git working copy.
ENV APACHE_DOCROOT_IN_REPO=""
