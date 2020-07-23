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

WORKDIR /go/src/github.com/heroku/terrier
RUN git clone https://github.com/heroku/terrier.git .
# let's try master
#RUN git checkout v0.2.0 && git checkout -b v0.2.0
# This seems to work with docker hub:
# skopeo version 0.1.41-dev commit: e955849f0aca02eb8a179808f0952e8cbea43ed7
#RUN git checkout e955849f0aca02eb8a179808f0952e8cbea43ed7
#RUN git checkout -b 0.1.41-dev
#RUN make binary-local-static DISABLE_CGO=1
#RUN make all DISABLE_CGO=1
RUN make build-linux64
#RUN /go/src/github.com/containers/skopeo/skopeo --version
#RUN /go/src/github.com/heroku/terrier/bin/terrier-linux-amd64 --version

FROM alpine:3.12
#RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/heroku/terrier/bin/terrier-linux-amd64 /usr/local/bin/terrier
COPY --from=builder /go/src/github.com/heroku/terrier/convertSHA.sh /usr/local/bin/convertSHA.sh
#COPY --from=builder /go/src/github.com/containers/skopeo/default-policy.json /etc/containers/policy.json
##ENTRYPOINT ["/usr/local/bin/skopeo"]
##CMD ["--help"]
