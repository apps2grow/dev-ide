ARG image=elicocorp/odoo:10.0
FROM $image

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="${PATH}:/usr/lib/jvm/java-11-openjdk-amd64/bin"

RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common \
 && add-apt-repository ppa:openjdk-r/ppa \
 && add-apt-repository ppa:mystic-mirage/pycharm \
 && apt-get update && apt-get install -y --no-install-recommends \
      openjdk-11-jdk \
      pycharm-community \
      python-pip \
 && yes | pip install \
      "cachetools>=2.0.1,<3.0.0" `#OCA/connector` \
      numpy                      `#apps2grow/apps2grow` \
      pandas                     `#apps2grow/apps2grow` \
      pyxb                       `#apps2grow/apps2grow` \
 && :




CMD /usr/bin/pycharm-community
ENTRYPOINT [ "/usr/bin/dumb-init", "/opt" ]
ENTRYPOINT [ "/usr/bin/dumb-init", "/usr/bin/pycharm-community" ]

#OCA/servertools letsencrypt
# apt install openssl
# pip install acme-tiny IPy
