FROM debian:wheezy

ENV http_proxy 'http://192.168.3.5:3128'
ENV https_proxy 'http://192.168.3.5:3128'
ENV HTTP_PROXY 'http://192.168.3.5:3128'
ENV HTTPS_PROXY 'http://192.168.3.5:3128'

RUN echo 'd-i apt-setup/no_mirror boolean true' | debconf-set-selections
RUN echo 'd-i mirror/http/hostname string http.us.debian.org' | debconf-set-selections
RUN echo 'd-i mirror/http/directory string /debian' | debconf-set-selections
RUN echo 'd-i mirror/http/proxy string' | debconf-set-selections

#ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y apt-utils && apt-get install -y gitolite

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

ADD debconf_selections /debconf_selections
ADD adminkey.pub /adminkey.pub

RUN debconf-set-selections /debconf_selections
RUN dpkg-reconfigure -fnoninteractive gitolite

RUN mkdir /var/run/sshd

RUN chown -R git:git /home/git

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
