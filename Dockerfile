FROM golang:1.13.0-alpine3.10 as builder

ENV HOME=$GOPATH/src/github.com/kubernetes-incubator/descheduler

WORKDIR $HOME
RUN mkdir -p $GOPATH/src/github.com/kubernetes-incubator && apk add --no-cache git make
RUN git clone https://github.com/kubernetes-incubator/descheduler.git $HOME
COPY .image-tag $HOME
RUN git checkout $(cat .image-tag) && make build

FROM alpine:3.10 as runner

COPY --from=builder /go/src/github.com/kubernetes-incubator/descheduler/_output/bin/descheduler /bin/descheduler
CMD descheduler
