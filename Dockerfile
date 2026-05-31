FROM ubuntu:latest

# Install SSHD dan setup environment
RUN apt-get update && apt-get install -y openssh-server sudo && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

# Set password root (Silakan ganti 'passwordrahasia' dengan password yang aman)
RUN echo 'root:vinzz' | chpasswd

# Izinkan login via password dan root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Railway butuh EXPOSE ini agar tahu port mana yang internal digunakan oleh container
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
