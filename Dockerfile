# -*- mode: dockerfile -*-

FROM alpine:latest
RUN apk --no-cache add ca-certificates go dep git bash openssh-client
RUN ls
COPY . /root/go/src/stripe-mock
COPY . /root/go/src/github.com/stripe/stripe-mock
WORKDIR /root/go/src/stripe-mock
RUN go get -u github.com/jteeuwen/go-bindata/...
ENV PATH $PATH:/root/go/bin
RUN ls /root/go/src/stripe-mock
RUN go generate
RUN ls
RUN go build
RUN ls
RUN cp stripe-mock /bin/stripe-mock
ENTRYPOINT ["/bin/stripe-mock", "-http-port", "12111", "-https-port", "12112"]
EXPOSE 12111
EXPOSE 12112
