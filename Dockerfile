FROM golang:1.20.0-alpine AS build

RUN apk update && apk upgrade && apk add --no-cache bash git

RUN mkdir -p /app/ddns-gdomains
WORKDIR /app/ddns-gdomains

COPY go.mod  .
RUN go mod download
COPY . .
RUN go get -d -v ./...
RUN go install -v ./...
RUN go build -o app cmd/ddns-gdomains/main.go

FROM alpine:latest as prod
RUN apk --no-cache add ca-certificates
COPY --from=build /app/ddns-gdomains/app /app
CMD ["/app"]
