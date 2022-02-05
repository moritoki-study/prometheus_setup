FROM amazonlinux:2.0.20211223.0

# yum update & install
RUN yum update -y \
    && yum install \
        systemd \
        tar \
        unzip \
        sudo \
        golang \
        httpd \
        vim \
        wget \
        hostname \
        -y

# setup golang test_httpserver
RUN wget https://raw.githubusercontent.com/kichiram/golang/main/testgo/test_httpserver.go \
  && go get github.com/prometheus/client_golang/prometheus \
  && go build test_httpserver.go \
  && mv test_httpserver /usr/local/bin/ 

# init
EXPOSE 8080
EXPOSE 8081
CMD ["/usr/local/bin/test_httpserver", "-D", "FOREGROUND"]
