FROM golang:1.12-alpine as build-base
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh make 
ADD . /go/src/github.com/travisjeffery/jocko
WORKDIR /go/src/github.com/travisjeffery/jocko
RUN GOOS=linux GOARCH=amd64 GO111MODULE=on make build

FROM alpine:latest
COPY --from=build-base /go/src/github.com/travisjeffery/jocko/cmd/jocko/jocko /usr/local/bin/jocko
EXPOSE 9092 9093 9094 9095
VOLUME "/tmp/jocko"
CMD ["jocko", "broker"]
