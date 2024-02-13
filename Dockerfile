FROM rockylinux:8
EXPOSE 80

ENV DEBIAN_FRONTEND noninteractive

RUN  yum install wget tar sudo bash curl procps -y


# Install ipfs using ipfs-update and initialize
RUN curl -Lo ipfs.tar.gz https://github.com/ipfs/kubo/releases/download/v0.19.0/kubo_v0.19.0_linux-amd64.tar.gz \
    && tar -xvzf ipfs.tar.gz \
    && cd ./kubo \
    && sudo bash install.sh \
    && ipfs init

# RUN df -h
# RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
# RUN yum install speedtest -y
# RUN speedtest -y


# config the peers

RUN ipfs config --json Internal.Bitswap.TaskWorkerCount 256
RUN ipfs config --json Internal.Bitswap.TaskWorkerCount 512
RUN ipfs config --json Internal.Bitswap.EngineBlockstoreWorkerCount 4096
RUN ipfs config --json Internal.Bitswap.EngineTaskWorkerCount 512
RUN ipfs config --json Reprovider.Interval '"1h"'
RUN ipfs config --json Datastore.GCPeriod '"12h"'


# config the port
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/80

RUN ipfs config --json Swarm.ConnMgr.HighWater 10000

RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'

# by default, run `ipfs daemon` to start as a running node
ENTRYPOINT ["ipfs"]
CMD ["daemon"]

