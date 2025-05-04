# Run Stream Host in Docker

This guide will walk you through the process of running the XMPro Stream Host in a Docker container.

## Prerequisites

- Docker installed on your host machine
- A valid [Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer
- Basic knowledge of Docker commands

## Quick Start

The quickest way to get started is to use the following Docker command, replacing the placeholders with your actual values:

```bash
docker run -d --name xmpro-stream-host \
  -e SERVER_URL="https://your-xmpro-server.com" \
  -e COLLECTION_ID="your-collection-id" \
  -e DEVICE_NAME="your-device-name" \
  -e SECRET="your-secret" \
  -e KEY="your-key" \
  xmpro/stream-host:latest
```

## Using a Connection Profile

For a more secure approach, you can use the Connection Profile file you downloaded from Data Stream Designer:

1. [Download the Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer.

2. Create a directory on your host machine to store the Connection Profile:

   ```bash
   mkdir -p /path/to/connection-profile
   ```

3. Copy the Connection Profile file to this directory.

4. Run the Docker container, mounting the directory containing the Connection Profile:

   ```bash
   docker run -d --name xmpro-stream-host \
     -v /path/to/connection-profile:/app/connection-profile \
     -e CONNECTION_PROFILE_PATH="/app/connection-profile/your-profile-file.json" \
     -e FILE_KEY="your-file-key" \
     xmpro/stream-host:latest
   ```

## Environment Variables

You can configure the Stream Host using the following environment variables:

| Variable | Description | Required if not using Connection Profile |
|----------|-------------|------------------------------------------|
| SERVER_URL | The URL of your XMPro server | Yes |
| COLLECTION_ID | The ID of the Collection | Yes |
| DEVICE_NAME | The name of the device (Stream Host) | Yes |
| SECRET | The secret from the Collection | Yes |
| KEY | The key from the Collection | Yes |
| CONNECTION_PROFILE_PATH | Path to the Connection Profile file inside the container | No |
| FILE_KEY | The key used when downloading the Connection Profile | Required if using Connection Profile |
| LOG_LEVEL | The logging level (Verbose, Debug, Information, Warning, Error, Fatal) | No |

## Persistent Storage

If you need to persist logs or other data, you can mount volumes to the container:

```bash
docker run -d --name xmpro-stream-host \
  -v /path/to/logs:/app/logs \
  -e SERVER_URL="https://your-xmpro-server.com" \
  -e COLLECTION_ID="your-collection-id" \
  -e DEVICE_NAME="your-device-name" \
  -e SECRET="your-secret" \
  -e KEY="your-key" \
  xmpro/stream-host:latest
```

## Docker Compose Example

For a more manageable setup, you can use Docker Compose. Create a `docker-compose.yml` file with the following content:

```yaml
version: '3'
services:
  stream-host:
    image: xmpro/stream-host:latest
    container_name: xmpro-stream-host
    restart: unless-stopped
    environment:
      - SERVER_URL=https://your-xmpro-server.com
      - COLLECTION_ID=your-collection-id
      - DEVICE_NAME=your-device-name
      - SECRET=your-secret
      - KEY=your-key
      # Or use Connection Profile:
      # - CONNECTION_PROFILE_PATH=/app/connection-profile/your-profile-file.json
      # - FILE_KEY=your-file-key
    volumes:
      # Uncomment if using Connection Profile:
      # - /path/to/connection-profile:/app/connection-profile
      - /path/to/logs:/app/logs
```

Then start the container with:

```bash
docker-compose up -d
```

## Verifying the Installation

To verify that the Stream Host is running correctly:

1. Check the container status:

   ```bash
   docker ps
   ```

   You should see the `xmpro-stream-host` container running.

2. Check the container logs:

   ```bash
   docker logs xmpro-stream-host
   ```

3. Log into Data Stream Designer, navigate to the Collections page, and select the Collection you used. The Stream Host should appear in the Devices list with a status of "Online".

## Troubleshooting

If your Stream Host is not appearing in the Collection:

1. Check the container logs for any error messages:

   ```bash
   docker logs xmpro-stream-host
   ```

2. Verify that the environment variables or Connection Profile are correctly configured.

3. Ensure that the container has internet access and can reach the XMPro server.

4. For more detailed troubleshooting, refer to the [Troubleshooting section](index.md#troubleshooting) in the main Stream Host documentation.

## Updating the Stream Host

To update to the latest version of the Stream Host:

1. Pull the latest image:

   ```bash
   docker pull xmpro/stream-host:latest
   ```

2. Stop and remove the existing container:

   ```bash
   docker stop xmpro-stream-host
   docker rm xmpro-stream-host
   ```

3. Start a new container using the same configuration as before.

## Security Considerations

- Store sensitive information like secrets and keys securely, using Docker secrets or environment variables from a secure source.
- Consider using a non-root user inside the container for added security.
- Regularly update the Stream Host image to get the latest security patches.
