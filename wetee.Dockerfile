FROM wetee/builder:0.0.1 AS builder
ADD ../ /srv
RUN chmod +x /srv/wetee/wetee_build.sh && chmod +x /srv/wetee/wetee_run.sh && /srv/wetee/wetee_build.sh


FROM wetee/builder:0.0.1

COPY --from=builder /srv/wetee /srv

CMD ["/bin/sh","/srv/wetee_run_linux.sh"]
EXPOSE 8008 8448