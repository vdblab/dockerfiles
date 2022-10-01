FROM        alpine
# dummy arg
ARG VERSION=1
# install openssl and the complete wget
# clean up cached artefacts
RUN apk --update add openssl wget zip tar \
    && rm -rf /var/cache/apk/*
