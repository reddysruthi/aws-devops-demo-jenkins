FROM ubuntu:20.04
MAINTAINER "sruthi <sruthi@gmail.com>"
RUN apt update && \
    apt install -y install nginx curl
EXPOSE 80
VOLUME /var/tmp
CMD ["nginx", "-g", "daemon off;"]
