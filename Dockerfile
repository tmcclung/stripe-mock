# -*- mode: dockerfile -*-

FROM alpine:latest
RUN apk --no-cache add ca-certificates go dep git bash openssh-client
COPY . /root/go/src/github.com/stripe/stripe-mock
WORKDIR /root/go/src/github.com/stripe/stripe-mock
RUN go get -u github.com/jteeuwen/go-bindata/...
ENV PATH $PATH:/root/go/bin
RUN go generate
RUN go build
RUN cp stripe-mock /bin/stripe-mock
ENTRYPOINT ["/bin/stripe-mock", "-http-port", "12111", "-https-port", "12112"]
EXPOSE 12111
EXPOSE 12112
