FROM alpine:latest
RUN set -euxo pipefail
RUN apk update && apk add --no-cache ca-certificates
RUN wget -q -O /usr/local/bin/irma https://github.com/privacybydesign/irmago/releases/download/v0.6.0/irma-master-linux-amd64
RUN chmod +x /usr/local/bin/irma
RUN echo "Installed IRMA 0.6.0."

COPY ./config ./config
CMD ["sh", "-c", "irma server -vv --config $CONFIG --url $BASE_URL"]

EXPOSE 8088
