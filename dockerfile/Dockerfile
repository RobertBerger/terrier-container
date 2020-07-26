FROM golang:1.14-alpine AS builder

RUN apk add --no-cache \
    git \
    make \
    gcc \
    musl-dev \
    btrfs-progs-dev \
    lvm2-dev \
    gpgme-dev \
    bash \
    glib-dev || apk update && apk upgrade

WORKDIR /go/src/github.com/robertberger/terrier
RUN git clone https://github.com/robertberger/terrier.git .
RUN git checkout 2020-07-24
RUN make build-linux64-static

FROM alpine:3.12
COPY --from=builder /go/src/github.com/robertberger/terrier/bin/terrier-linux-amd64-static /usr/local/bin/terrier
COPY --from=builder /go/src/github.com/robertberger/terrier/convertSHA.sh /usr/local/bin/convertSHA.sh
