FROM ubuntu:22.10

ADD config /srv/config
ADD dendrite /srv/
ADD matrix_key.pem /srv/

WORKDIR /srv/

CMD ["/srv/dendrite","-really-enable-open-registration","--tls-cert","config/server.crt","--tls-key","config/server.key","--config","config/pro.yaml"]
EXPOSE 8008 8448