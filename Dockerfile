FROM rockylinux:8
EXPOSE 5001

ENV DEBIAN_FRONTEND noninteractive

RUN  yum install wget tar sudo bash curl procps -y


# Install ipfs using ipfs-update and initialize
RUN wget https://dist.ipfs.tech/kubo/v0.18.0/kubo_v0.18.0_linux-amd64.tar.gz \
    && tar -xvzf kubo_v0.18.0_linux-amd64.tar.gz \
    && cd ./kubo \
    && sudo bash install.sh \
    && ipfs init


# config the peers
RUN ipfs config --json Peering.Peers '[{"Addrs":["/dns4/checkpoint-hk.ipns.network/tcp/4001","/dns4/checkpoint-hk.ipns.network/udp/4001/quic"],"ID":"12D3KooWQzZ931qqFJHER6wmmafMdV3ykxULczRsW83o5pJaBMTV"},{"Addrs":["/dns4/checkpoint-sg.ipns.network/tcp/4001","/dns4/checkpoint-sg.ipns.network/udp/4001/quic"],"ID":"12D3KooWNke2bS34fxQrGrnx27UbWMNsWLKDNPEEo8tLyS1K22Ee"},{"Addrs":["/dns4/checkpoint-us.ipns.network/tcp/4001","/dns4/checkpoint-us.ipns.network/udp/4001/quic"],"ID":"12D3KooWSgRgfLxfDdi2eDRVBpBYFuTZp39HEBYnJm1upCUJ2GYz"},{"Addrs":["/ip4/185.143.45.58/tcp/4001","/ip4/185.143.45.58/udp/4001/quic"],"ID":"12D3KooWPE1U1x31QteygQ7a34tzqx5FFJ3B5ttrfWjAqTn8kHo1"},{"Addrs":["/ip4/195.15.245.11/tcp/4001","/ip6/2001:1600:10:101::37e/tcp/4001","/ip4/195.15.245.11/udp/4001/quic"],"ID":"12D3KooWRHKJzo1ajNGBJnjeaunXXL9jNkEwsEi32KHMQkS5pm3t"},{"Addrs":["/ip4/178.79.129.236/tcp/4001","/ip4/178.79.129.236/udp/4001/quic","/ip6/2a01:7e00::f03c:92ff:fe15:336c/tcp/4001","/ip6/2a01:7e00::f03c:92ff:fe15:336c/udp/4001/quic"],"ID":"12D3KooWPJtc5zoUGcPRAqvTvGU3w8gs5FmMQaqvNTnZVQCnD1So"},{"Addrs":["/ip4/144.22.227.229/tcp/4001","/ip4/144.22.227.229/udp/4001/quic"],"ID":"12D3KooWHrmMDXWiBu4DT27ykCjJGZoF1aN2RhMTLcDVQR3SER9a"},{"Addrs":["/ip4/167.99.123.6/tcp/4001","/ip4/167.99.123.6/udp/4001/quic"],"ID":"12D3KooWKsBxZVe4ycB1hkxsFuLkHvkZPtwpi3VMQmNrHhApUTTL"},{"Addrs":["/ip4/121.36.203.35/tcp/4001"],"ID":"12D3KooWR8oBt5QbFQosGbQUa5Hfg83Ktgve18pd5ozEJgU3jW9a"},{"Addrs":["/ip4/147.75.80.39/tcp/4001"],"ID":"12D3KooWDdzN3snjaMJEH9zuq3tjKUFpYHeSGNkiAreF6dQSbCiL"},{"Addrs":["/ip4/136.144.57.15/tcp/4001"],"ID":"12D3KooWJEfH2MB4RsUoaJPogDPRWbFTi8iehsxsqrQpiJwFNDrP"},{"Addrs":["/dnsaddr/bootstrap.libp2p.io"],"ID":"QmNnooDu7bfjPFoTZYxMNLWUQJyrVwtbZg5gBMjTezGAJN"},{"Addrs":["/ip4/103.94.185.112/tcp/4001"],"ID":"12D3KooWDDV7XzfZtY5Uve6adwFiRXu6J6ypQHALNuA7r9qXvQDr"},{"Addrs":["/dnsaddr/bootstrap.libp2p.io"],"ID":"QmQCU2EcMqAqQPR2i9bChDtGNJchTbq5TbXJJ16u19uLTa"},{"Addrs":["/dnsaddr/bootstrap.libp2p.io"],"ID":"QmbLHAnMoJPWSCR5Zhtx6BHJX9KiKNN6tpvbUcqanj75Nb"},{"Addrs":["/dnsaddr/bootstrap.libp2p.io"],"ID":"QmcZf59bWwK5XFi76CZX8cbJ4BhTzzA3gU1ZjYZcYW3dwt"},{"Addrs":["/ip4/35.213.92.184/udp/4001/quic"],"ID":"12D3KooWNXWXBhgiTjbVJFYjreU2R8LxbsoibaUvBMNpAgUfGHez"},{"Addrs":["/ip4/121.43.63.12/udp/4001/quic"],"ID":"QmVo7518mdbDMTzK7gydgEmc8vnCM8Q3qmRjJiQ4WYSEzJ"},{"Addrs":["/ip4/61.155.145.154/udp/4001/quic","/ip4/61.155.145.154/tcp/4001"],"ID":"12D3KooWBHh27DAZAz2BByqx1SvJDpF492aMZZPZQJqphdQkiJdj"},{"Addrs":["/ip4/47.113.108.93/udp/4001/quic"],"ID":"12D3KooWAM1haZQphjtrvUtbfAJ43cSZXDxKY9ZDxTA2eXbtzcbh"},{"Addrs":["/ip4/101.201.82.132/tcp/4001"],"ID":"12D3KooWDS4tPYnTRPC8hGV6C4RUzSpdavgp4w9ZTPLULJNBEUzs"},{"Addrs":["/ip6/2a02:c207:2027:7097:3b61::3/tcp/4001"],"ID":"QmRsoMZdvm4xHHQUvjYGGbasdaYrh3jhoo6jsDCig6vHVN"}]'

RUN ipfs config --json Internal.Bitswap.TaskWorkerCount 256
RUN ipfs config --json Internal.Bitswap.TaskWorkerCount 512
RUN ipfs config --json Internal.Bitswap.EngineBlockstoreWorkerCount 4096
RUN ipfs config --json Internal.Bitswap.EngineTaskWorkerCount 512
RUN ipfs config --json Reprovider.Interval '"1h"'
RUN ipfs config --json Datastore.GCPeriod '"12h"'


# config the port
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/80
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001

# by default, run `ipfs daemon` to start as a running node
ENTRYPOINT ["ipfs"]
CMD ["daemon"]

