FROM ubuntu:latest

LABEL maintainer "Kuromesi"
LABEL version "1.0"
LABEL description "Wazuh Agent"

COPY entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
RUN apt-get update && apt-get install -y \
  procps curl apt-transport-https gnupg2&& \
  curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
  echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list && \
  apt-get update && \
  WAZUH_MANAGER="10.147.1.0" apt-get -y install wazuh-agent && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
