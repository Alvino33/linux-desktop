FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

# Membuat folder SSH untuk root
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Masukkan isi Public Key dari Termius kamu ke sini
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZP4HLl/F+Xo3eFegxStAIHuoFiO2T9a/xCJBssrPfL" > /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Matikan login pakai password secara total (Hanya bisa masuk pakai Key)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
