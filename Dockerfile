FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Desktop Environment yang enteng (XFCE) dan noVNC
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    novnc websockify \
    python3 \
    curl \
    && apt-get clean

# Setting folder VNC
RUN mkdir -p ~/.vnc

# Set password VNC: vinogg (Bisa lo ganti sesuka hati)
RUN echo "vinogg" | vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd

# Buat script buat jalanin semuanya otomatis
RUN echo "#!/bin/bash\n\
vncserver :1 -geometry 1280x720 -depth 24\n\
websockify --web /usr/share/novnc/ 8080 localhost:5901" > /start.sh && chmod +x /start.sh

# Port buat noVNC biar bisa dibuka di browser HP lu
EXPOSE 8080

CMD ["/start.sh"]
