#! /bin/bash

set -euxo pipefail

function install_kafka() {
    wget http://kafka.apache.org/KEYS
    wget https://dist.apache.org/repos/dist/release/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz.asc
    wget http://mirror.symnds.com/software/Apache/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz

    # Verify download
    gpg --import KEYS
    gpg --verify kafka_2.11-0.10.0.0.tgz.asc kafka_2.11-0.10.0.0.tgz

    # Extract and install
    tar xzf kafka_2.11-0.10.0.0.tgz
    mv kafka_2.11-0.10.0.0 /opt/kafka
    rm -f kafka_2.11-0.10.0.0.tgz



    useradd --user-group --no-create-home --system kafka

    mkdir -p /data1
    mkdir -p /var/log/kafka
    mkdir -p /opt/kafka/tls

    chown -R kafka:kafka /data1
    chown -R kafka:kafka /var/log/kafka

    touch /var/run/kafka.pid
    chown kafka:kafka /var/run/kafka.pid
}

function cleanup() {
    apt-get autoclean -y
    apt-get clean -y
    apt-get autoremove -y

    rm -rf $PWD/.gnupg
    rm -rf $PWD/*
}

install_kafka
cleanup