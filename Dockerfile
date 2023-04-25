FROM alpine as builder
ARG VERSION
RUN apk --update add ca-certificates \
                     mailcap \
                     curl

HEALTHCHECK --start-period=2s --interval=5s --timeout=3s \
  CMD curl -f http://localhost:8080/health || exit 1

VOLUME /srv
EXPOSE 8080

COPY docker_config.json /.filebrowser.json
COPY --from=builder /usr/local/bin/filebrowser  /filebrowser

ENTRYPOINT [ "/filebrowser" ]
