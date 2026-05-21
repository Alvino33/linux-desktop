FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=10000

RUN apt update && \
    apt install -y \
    openssh-server \
    python3 \
    curl \
    wget \
    ssh && \
    mkdir -p /run/sshd

RUN echo "root:root123" | chpasswd

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

EXPOSE 10000

CMD bash -c "\
service ssh start && \
python3 -m http.server 10000 & \
ssh \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null \
-p 443 \
-R0:localhost:22 \
tcp@a.pinggy.io"
