# Use a minimal Alpine Linux base image for a small footprint
FROM alpine:3.18

# Set environment variables for the PocketBase version and build flags
# It's a good practice to use a specific version rather than "latest"
ENV PB_VERSION="0.22.10"
ENV PB_DOWNLOAD_URL="https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip"

# Install necessary packages for unzipping and basic operations
RUN apk add --no-cache ca-certificates unzip

# Create the PocketBase directory and set it as the working directory
WORKDIR /app

# Download the PocketBase binary from GitHub
RUN wget ${PB_DOWNLOAD_URL} -O /tmp/pocketbase.zip \
    && unzip /tmp/pocketbase.zip -d /app \
    && rm /tmp/pocketbase.zip

# Create a separate volume for data (database and file uploads)
# This ensures that your data is not lost when the container is recreated
# For local development, you'd bind-mount a host directory here
# For production, this becomes a managed volume
VOLUME /pb_data

# Copy custom user-defined PocketBase migrations and hooks (if any)
# This assumes you have your custom scripts in a 'pb_hooks' directory
# in the same location as your Dockerfile.
COPY ./pb_hooks /app/pb_hooks

# Expose the default PocketBase port
# This is the port your container will listen on
EXPOSE 8090

# Set the entrypoint to run the PocketBase executable
# This will automatically start the server when the container is run
# The `--dir` flag tells PocketBase where to store its data
ENTRYPOINT ["/app/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]