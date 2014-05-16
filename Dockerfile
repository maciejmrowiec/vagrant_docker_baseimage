
# Ubuntu Vagrant Base Box

FROM ubuntu

MAINTAINER Maciej Mrowiec <azxsys@gmail.com>

RUN apt-get update && \
    apt-get install openssh-server -y && \
    apt-get install sudo -y && \
    apt-get install curl -y && \
    apt-get install nfs-common -y && \
    apt-get install vim -y && \
    apt-get clean

RUN useradd --create-home -s /bin/bash vagrant
RUN sudo usermod -a -G sudo vagrant
WORKDIR /home/vagrant

# Configure SSH access for vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN adduser vagrant sudo
RUN echo -n 'vagrant:vagrant' | chpasswd

RUN echo -n '%sudo ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo_nopass 
RUN chmod 0440 /etc/sudoers.d/sudo_nopass

# Thanks to http://docs.docker.io/en/latest/examples/running_ssh_service/
RUN mkdir /var/run/sshd

CMD /usr/sbin/sshd -D
