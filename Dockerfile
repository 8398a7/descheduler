FROM golang:1.12.6-alpine3.9 as builder

ENV \
  HOME=$GOPATH/src/github.com/kubernetes-incubator/descheduler \
  GO111MODULE=on

WORKDIR $HOME
RUN mkdir -p $GOPATH/src/github.com/kubernetes-incubator && apk add --no-cache git make
RUN git clone https://github.com/kubernetes-incubator/descheduler.git $HOME
RUN git checkout 0.9.0 && make build

FROM alpine:3.10 as runner

COPY --from=builder /go/src/github.com/kubernetes-incubator/descheduler/_output/bin/descheduler /bin/descheduler
CMD descheduler
