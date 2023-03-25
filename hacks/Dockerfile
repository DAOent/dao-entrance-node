FROM ubuntu:22.10

ADD pro.yaml /srv/
ADD dendrite /srv/
ADD server.crt /srv/
ADD server.key /srv/
ADD matrix_key.pem /srv/

WORKDIR /srv/

CMD ["/srv/dendrite","--tls-cert","server.crt","--tls-key","server.key","--config","pro.yaml"]
EXPOSE 8008 8448