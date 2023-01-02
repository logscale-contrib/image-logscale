ARG logscale_version=1.67.0 
FROM --platform=linux/amd64 humio/humio-core:${logscale_version} AS binaries

FROM ghcr.io/logscale-contrib/image-logscale-azul-19-base/container:1.0.1

#
# Pull Zulu OpenJDK binaries from official repository:
#
ARG logscale_user=humio

RUN mkdir -p /data/humio-data /data/logs /backup ;\
    chown -R nobody:nobody /data ;\
    chown -R nobody:nobody /backup

COPY --from=binaries /app /app

WORKDIR /app/humio
EXPOSE 8080
USER nobody
CMD ["/bin/sh","/app/humio/run.sh"]
