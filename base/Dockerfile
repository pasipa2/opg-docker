FROM phusion/baseimage:0.9.22

ENV HOME="/root"                     \
    DEBIAN_FRONTEND="noninteractive" \
    LANG="en_GB.UTF-8"               \
    LANGUAGE="en_GB:en"              \
    LC_ALL="en_GB.UTF-8"             \
    OPG_SERVICE="base"               \
    BEAVER_VERSION="36.2.1"          \
    CONFD_VERSION="0.15.0"           \
    GOSU_VERSION="1.10"

COPY docker /

RUN locale-gen en_GB en_GB.UTF-8 &&\
    echo "Installing Gosu" &&\
    gpg --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 &&\
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" &&\
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" &&\
    gpg -q --verify /usr/local/bin/gosu.asc &&\
    rm /usr/local/bin/gosu.asc &&\
    chmod +x /usr/local/bin/gosu 
RUN echo "Updating Packages" &&\
    apt-get update &&\
    apt-get install -y git dnsmasq unzip zip python python-pip
RUN echo "Installing log aggregation and AWSCLI" &&\
    pip install -U pip &&\
    pip install awscli Beaver==${BEAVER_VERSION} &&\
    mkdir -p /etc/beaver.d &&\
    chmod a+x /etc/sv/beaver/run &&\
    ln -s /etc/sv/beaver /etc/service/
RUN echo "Installing ConfD" &&\
    curl -o /usr/bin/confd -SL "https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64" &&\
    chmod a+x /usr/bin/confd &&\
    mkdir -p /etc/confd/conf.d /etc/confd/templates
RUN echo "Disaling ssh access" &&\
    rm /etc/my_init.d/00_regen_ssh_host_keys.sh &&\
    rm -rf /etc/service/sshd || true &&\
    echo "Application user and location" &&\
    useradd -m -d /app app &&\
    mkdir -p /var/log/app /data /var/run/app &&\
    chown app /var/log/app /data /var/run/app &&\
    echo "Providing a resolver at localhost for software that can't/won't use /etc/resolv.conf" &&\
    chmod a+x /etc/service/dnsmasq/run &&\
    echo "Disabling MTU on vixie cron" &&\
    chmod 600 /var/spool/cron/crontabs/root &&\
    chmod 600 /var/spool/cron/crontabs/app &&\
    chown app:crontab /var/spool/cron/crontabs/app && \
    chmod a+x /etc/my_init.d/* &&\
    mkdir -p /scripts/base &&\
    chmod -R a+x /scripts/base
