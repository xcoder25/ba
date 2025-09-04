FROM alpine:latest

WORKDIR /pb

# Install CA certificates for HTTPS
RUN apk add --no-cache ca-certificates unzip curl

# Download PocketBase (replace version if needed)
RUN curl -L https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_0.22.10_linux_amd64.zip -o pb.zip \
    && unzip pb.zip -d /pb \
    && rm pb.zip

# Persistent data directory
VOLUME /pb/pb_data

EXPOSE 8090

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
