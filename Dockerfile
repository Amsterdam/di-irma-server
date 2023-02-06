FROM alpine:latest
RUN set -euxo pipefail
# Add ADP root certificate manually to the trust list to ensure that we don't get SSL error
# running 'apk add ca-certificates' (due to Motiv SSL inspection).
COPY adp_rootca.crt /usr/local/share/ca-certificates/
RUN cat /usr/local/share/ca-certificates/adp_rootca.crt >> /etc/ssl/certs/ca-certificates.crt
RUN apk add --no-cache ca-certificates
# Remove the certificate trust list and regenerate it the official way.
# The update-ca-certificates command generates a warning which can be ignored;
# it will still generate the ca-certificates.crt file fully.
RUN rm /etc/ssl/certs/ca-certificates.crt
RUN update-ca-certificates --fresh
RUN wget -q -O /usr/local/bin/irma https://github.com/privacybydesign/irmago/releases/download/v0.11.1/irma-linux-amd64
RUN chmod +x /usr/local/bin/irma
COPY ./config ./config
CMD irma server -v --config $CONFIG --url $BASE_URL --sse --no-email
EXPOSE 8088
