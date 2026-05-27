FROM ubuntu:22.04
RUN apt update && apt install -y wget tar
RUN wget https://github.com/xmrig/xmrig/releases/download/v6.22.0/xmrig-6.22.0-linux-x64.tar.gz
RUN tar -xf xmrig-6.22.0-linux-x64.tar.gz && mv xmrig-6.22.0 xmrig
COPY config.json /xmrig/config.json
CMD ["/xmrig/xmrig", "-c", "/xmrig/config.json"]
