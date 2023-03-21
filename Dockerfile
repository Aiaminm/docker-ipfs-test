FROM rockylinux:8
EXPOSE 80

ENV DEBIAN_FRONTEND noninteractive

RUN  yum install wget tar sudo bash curl procps -y


# Install ipfs using ipfs-update and initialize
RUN wget https://dist.ipfs.tech/kubo/v0.18.0/kubo_v0.18.0_linux-amd64.tar.gz \
    && tar -xvzf kubo_v0.18.0_linux-amd64.tar.gz \
    && cd ./kubo \
    && sudo bash install.sh \
    && ipfs init


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

RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'

# by default, run `ipfs daemon` to start as a running node
ENTRYPOINT ["ipfs"]
CMD ["daemon"]

