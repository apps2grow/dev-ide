ARG image=elicocorp/odoo:12.0
FROM $image

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="${PATH}:/usr/lib/jvm/java-11-openjdk-amd64/bin"

RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common \
 && add-apt-repository ppa:openjdk-r/ppa \
 && add-apt-repository ppa:mystic-mirage/pycharm \
 && apt-get update && apt-get install -y --no-install-recommends \
      openjdk-11-jdk             `#pycharm` \
      openssl                    `#OCA/servertools letsencrypt` \
      pycharm-community \
      python3-pip \
 && yes | pip3 install \
      acme-tiny                  `#OCA/servertools letsencrypt` \
      "cachetools>=2.0.1,<3.0.0" `#OCA/connector` \
      IPy                        `#OCA/servertools letsencrypt` \
      numpy                      `#apps2grow/apps2grow` \
      openupgradelib \
      pandas                     `#apps2grow/apps2grow` \
      pyxb                       `#apps2grow/apps2grow` \
 && :
