FROM ruby:2.5-stretch

MAINTAINER Kouhei Sutou <kou@clear-code.com>

RUN \
  apt update && \
  apt install -y apt-transport-https && \
  wget -O /usr/share/keyrings/red-data-tools-keyring.gpg \
    https://packages.red-data-tools.org/debian/red-data-tools-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/red-data-tools-keyring.gpg] https://packages.red-data-tools.org/debian/ stretch main" > \
    /etc/apt/sources.list.d/red-data-tools.list && \
  apt update

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN bundle install
