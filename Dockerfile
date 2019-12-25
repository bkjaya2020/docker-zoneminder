FROM ubuntu:bionic
MAINTAINER B.K.Jayasundera

# Update base packages
RUN apt update \
    && apt upgrade --assume-yes

# Install pre-reqs
RUN apt install --assume-yes --no-install-recommends gnupg

# Configure Zoneminder PPA
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABE4C7F993453843F0AEB8154D0BF748776FFB04 \
    && echo deb http://ppa.launchpad.net/iconnor/zoneminder-1.32/ubuntu bionic main > /etc/apt/sources.list.d/zoneminder.list \
    && apt update
RUN apt update && apt install -y tzdata
RUN apt install -y msmtp


# Install zoneminder
RUN apt install --assume-yes zoneminder 
    
# Set our volumes before we attempt to configure apache
VOLUME /var/cache/zoneminder/events /var/lib/mysql /var/log/zm

RUN chmod 740 /etc/zm/zm.conf
RUN chown root:www-data /etc/zm/zm.conf
RUN adduser www-data video
RUN a2enmod cgi
RUN a2enconf zoneminder
RUN a2enmod rewrite
RUN chown -R www-data:www-data /usr/share/zoneminder/
RUN ln -s /usr/bin/msmtp /usr/sbin/sendmail

# Expose http port
EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]
