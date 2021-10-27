FROM golang:1.17 AS build-env

COPY go.mod /src/

RUN  cd /src && go mod download

COPY . /src
RUN cd /src && CGO_ENABLED=0 GOOS=linux go build -o app
RUN useradd -u 10001 scratchuser

FROM scratch
WORKDIR /
COPY --from=build-env /etc/passwd /etc/passwd
COPY --from=build-env /etc/ssl/certs/ca-certificates.crt  /etc/ssl/certs/
COPY --from=build-env /src/app .
USER scratchuser
CMD ["./app"]