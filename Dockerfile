FROM ubuntu:22.04
RUN apt update && apt install -y wget tar
RUN wget https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz
RUN tar -xf xmrig-6.22.2-linux-static-x64.tar.gz && cd xmrig-6.22.2 && mv xmrig /xmrig
COPY config.json /xmrig/config.json
CMD ["/xmrig", "-c", "/xmrig/config.json"]
