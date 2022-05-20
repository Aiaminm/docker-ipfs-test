FROM golang:latest
LABEL maintainer "Baohua Yang <yangbaohua@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

#ENV API_PORT 5002
ENV GATEWAY_PORT 80
#ENV SWARM_PORT 4001

#EXPOSE ${SWARM_PORT}
# This may introduce security risk to expose API_PORT public
#EXPOSE ${API_PORT}
#EXPOSE ${GATEWAY_PORT}

# Install ipfs using ipfs-update and initialize
RUN go get -u github.com/ipfs/ipfs-update \
    && ipfs-update install latest \
    && ipfs init

# config the api endpoint, may introduce security risk to expose API_PORT public
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001

# config the gateway endpoint
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/80

# by default, run `ipfs daemon` to start as a running node
ENTRYPOINT ["ipfs"]
CMD ["daemon"]
