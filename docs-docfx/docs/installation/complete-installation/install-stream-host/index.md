# Stream Host Installation

The XMPro Stream Host is a component that runs on a device or server and connects to the XMPro platform to execute Data Streams. This section provides installation guides for different environments.

## Overview

The Stream Host can be installed in various environments:

- [Windows (x64)](windows-x64.md) - Install on a Windows 64-bit machine
- [Ubuntu (16.04+ x64)](ubuntu-16.04+-x64.md) - Install on Ubuntu Linux
- [Docker](docker.md) - Run in a Docker container
- [Azure Web Job](azure-web-job.md) - Deploy as an Azure Web Job

Choose the installation method that best fits your infrastructure and requirements.

## Prerequisites

Before installing the Stream Host, you need:

1. Access to Data Stream Designer in your XMPro environment
2. A Collection created in Data Stream Designer
3. Appropriate permissions to install software on your target environment

## Download the Installer

To download the Stream Host installer:

1. Log into Data Stream Designer.
2. Navigate to the Collections page.
3. Select the Collection where you want to add the Stream Host.
4. Click on the **Devices** tab.
5. Click **Add Device**.
6. Enter a name for your Stream Host.
7. Click **Download Installer**.
8. Select the appropriate installer for your environment:
   - Windows (x64): `.exe` installer
   - Ubuntu (16.04+ x64): `.tar.gz` archive
   - Docker: Use the Docker image from Docker Hub
   - Azure Web Job: Use the Windows installer and follow the Azure Web Job guide

## Download the Connection Profile

The Connection Profile contains the configuration needed for the Stream Host to connect to your XMPro environment:

1. After downloading the installer, click **Download Connection Profile**.
2. Enter a File Key (password) to secure the Connection Profile.
3. Remember this File Key as you'll need it during installation.
4. Click **Download** to save the Connection Profile file.

## Installation Process

The general installation process follows these steps:

1. Download the appropriate installer and Connection Profile.
2. Install the Stream Host on your target environment.
3. Configure the Stream Host with your Connection Profile.
4. Start the Stream Host service.
5. Verify the installation by checking the status in Data Stream Designer.

For detailed instructions, refer to the specific installation guide for your environment.

## Troubleshooting

If you encounter issues during installation or operation of the Stream Host:

### Common Issues

1. **Stream Host not appearing in Collection**:
   - Verify that the Stream Host service is running.
   - Check that the Connection Profile was correctly configured.
   - Ensure the machine has internet access and can reach the XMPro server.

2. **Connection errors**:
   - Check firewall settings to ensure the Stream Host can communicate with the XMPro server.
   - Verify that the Collection ID, Secret, and Key in the Connection Profile are correct.

3. **Service not starting**:
   - Check the Stream Host logs for error messages.
   - Verify that the required dependencies are installed.
   - Ensure the user running the service has appropriate permissions.

### Logs

The Stream Host logs can provide valuable information for troubleshooting:

- **Windows**: Logs are stored in the installation directory under the `Logs` folder.
- **Ubuntu**: Check the systemd journal with `journalctl -u xmpro-stream-host`.
- **Docker**: View container logs with `docker logs xmpro-stream-host`.
- **Azure Web Job**: Check the Web Job logs in the Azure Portal.

### Support

If you continue to experience issues, contact XMPro Support with the following information:

- Stream Host version
- Installation environment details
- Relevant log files
- Description of the issue
- Steps to reproduce the issue
