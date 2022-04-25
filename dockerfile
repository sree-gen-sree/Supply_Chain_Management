FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y sudo

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN node --version
RUN npm --version
RUN apt-get update -y && apt-get install -y git
# RUN apk update && apk upgrade && apk add --no-cache bash git openssh
# RUN apk add --update python3 krb5 krb5-libs gcc make g++ krb5-dev
WORKDIR /usr/app
RUN sudo npm install -g truffle
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install
COPY . .

EXPOSE 3000
