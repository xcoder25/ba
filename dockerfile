FROM alpine:latest

WORKDIR /pb

# Install CA certificates (for HTTPS requests from PocketBase)
RUN apk add --no-cache ca-certificates

# Copy binary into container
COPY pocketbase /pb/pocketbase

# Create a folder for persistent data
VOLUME /pb/pb_data

EXPOSE 8090

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
