# Install Stream Host on Ubuntu (16.04+ x64)

This guide will walk you through the process of installing the XMPro Stream Host on Ubuntu 16.04 or later (64-bit).

## Prerequisites

- Ubuntu 16.04 or later (64-bit)
- .NET Core 3.1 or later installed
- Sudo privileges on the machine
- A valid [Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer

## Installation Steps

### 1. Install .NET Core Runtime

If you don't have .NET Core installed, you'll need to install it first:

```bash
# Add the Microsoft package repository
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Install .NET Core Runtime
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-runtime-3.1
```

### 2. Download the Stream Host

1. [Download the Stream Host installer](index.md#download-the-installer) for Linux (x64) from Data Stream Designer.

2. Create a directory for the Stream Host:

   ```bash
   sudo mkdir -p /opt/xmpro/stream-host
   ```

3. Extract the downloaded archive to the directory:

   ```bash
   sudo tar -xzf XMPro.StreamHost.Linux-x64.tar.gz -C /opt/xmpro/stream-host
   ```

4. Set the appropriate permissions:

   ```bash
   sudo chmod +x /opt/xmpro/stream-host/XMPro.StreamHost
   ```

### 3. Configure the Connection Profile

1. [Download the Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer.

2. Copy the Connection Profile to the Stream Host directory:

   ```bash
   sudo cp /path/to/your/connection-profile.json /opt/xmpro/stream-host/
   ```

3. Create a configuration file:

   ```bash
   sudo nano /opt/xmpro/stream-host/appsettings.json
   ```

4. Add the following content, replacing the placeholders with your actual values:

   ```json
   {
     "ConnectionProfile": {
       "Path": "/opt/xmpro/stream-host/connection-profile.json",
       "FileKey": "your-file-key"
     },
     "Logging": {
       "LogLevel": {
         "Default": "Information",
         "Microsoft": "Warning",
         "System": "Warning"
       }
     }
   }
   ```

5. Save and close the file (Ctrl+X, then Y, then Enter).

### 4. Create a Systemd Service

1. Create a systemd service file:

   ```bash
   sudo nano /etc/systemd/system/xmpro-stream-host.service
   ```

2. Add the following content:

   ```ini
   [Unit]
   Description=XMPro Stream Host
   After=network.target

   [Service]
   WorkingDirectory=/opt/xmpro/stream-host
   ExecStart=/opt/xmpro/stream-host/XMPro.StreamHost
   Restart=always
   RestartSec=10
   SyslogIdentifier=xmpro-stream-host
   User=root
   Environment=ASPNETCORE_ENVIRONMENT=Production

   [Install]
   WantedBy=multi-user.target
   ```

3. Save and close the file (Ctrl+X, then Y, then Enter).

4. Reload the systemd daemon:

   ```bash
   sudo systemctl daemon-reload
   ```

5. Enable the service to start on boot:

   ```bash
   sudo systemctl enable xmpro-stream-host
   ```

6. Start the service:

   ```bash
   sudo systemctl start xmpro-stream-host
   ```

## Running as a Non-Root User (Recommended)

For better security, it's recommended to run the Stream Host as a non-root user:

1. Create a dedicated user for the Stream Host:

   ```bash
   sudo useradd -r -s /bin/false xmpro
   ```

2. Change the ownership of the Stream Host directory:

   ```bash
   sudo chown -R xmpro:xmpro /opt/xmpro/stream-host
   ```

3. Update the systemd service file:

   ```bash
   sudo nano /etc/systemd/system/xmpro-stream-host.service
   ```

4. Change the `User` line from `root` to `xmpro`:

   ```ini
   User=xmpro
   ```

5. Save and close the file, then reload the daemon and restart the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart xmpro-stream-host
   ```

## Verifying the Installation

To verify that the Stream Host is running correctly:

1. Check the service status:

   ```bash
   sudo systemctl status xmpro-stream-host
   ```

   You should see "active (running)" in the output.

2. Check the logs:

   ```bash
   sudo journalctl -u xmpro-stream-host -f
   ```

3. Log into Data Stream Designer, navigate to the Collections page, and select the Collection you used in the Connection Profile. The Stream Host should appear in the Devices list with a status of "Online".

## Troubleshooting

If your Stream Host is not appearing in the Collection:

1. Check the service status:

   ```bash
   sudo systemctl status xmpro-stream-host
   ```

2. View the logs:

   ```bash
   sudo journalctl -u xmpro-stream-host -f
   ```

3. Verify that the Connection Profile was correctly configured.

4. Ensure that the machine has internet access and can reach the XMPro server.

5. Check if any firewall rules are blocking the connection:

   ```bash
   sudo ufw status
   ```

6. For more detailed troubleshooting, refer to the [Troubleshooting section](index.md#troubleshooting) in the main Stream Host documentation.

## Uninstalling

To uninstall the Stream Host:

1. Stop and disable the service:

   ```bash
   sudo systemctl stop xmpro-stream-host
   sudo systemctl disable xmpro-stream-host
   ```

2. Remove the service file:

   ```bash
   sudo rm /etc/systemd/system/xmpro-stream-host.service
   sudo systemctl daemon-reload
   ```

3. Remove the Stream Host directory:

   ```bash
   sudo rm -rf /opt/xmpro/stream-host
   ```

4. (Optional) Remove the user if you created one:

   ```bash
   sudo userdel xmpro
