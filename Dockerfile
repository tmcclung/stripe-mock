# -*- mode: dockerfile -*-

FROM alpine:latest
RUN apk --no-cache add ca-certificates go dep git pushd popd
COPY . /root/go/src/stripe-mock
WORKDIR /root/go/src/stripe-mock
RUN go env
RUN go get -u github.com/jteeuwen/go-bindata/...
RUN pushd openapi/ && git pull origin master && popd
RUN go generate
RUN go build
RUN ls
RUN dep init
RUN cp stripe-mock /bin/stripe-mock
ENTRYPOINT ["/bin/stripe-mock", "-http-port", "12111", "-https-port", "12112"]
EXPOSE 12111
EXPOSE 12112
