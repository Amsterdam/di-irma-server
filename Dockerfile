FROM alpine:latest
RUN set -euxo pipefail

COPY adp_rootca.crt /usr/local/share/ca-certificates/

RUN apk update && apk add --no-cache ca-certificates && update-ca-certificates
RUN wget -q -O /usr/local/bin/irma https://github.com/privacybydesign/irmago/releases/download/v0.6.0/irma-master-linux-amd64
RUN chmod +x /usr/local/bin/irma

COPY ./config ./config
CMD ["sh", "-c", "irma server -vv --config ./config/irmaserver.json --url $BASE_URL --sse --no-email"]

EXPOSE 8088
