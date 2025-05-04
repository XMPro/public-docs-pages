# Install Stream Host on Windows (x64)

This guide will walk you through the process of installing the XMPro Stream Host on a Windows 64-bit system.

## Prerequisites

- Windows 10 or later (64-bit)
- .NET Framework 4.7.2 or later
- Administrator privileges on the machine
- A valid [Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer

## Installation Steps

1. [Download the Stream Host installer](index.md#download-the-installer) for Windows (x64) from Data Stream Designer.

2. Locate the downloaded installer file (typically named `XMPro.StreamHost.Installer.exe`) and double-click to run it.

3. If prompted by User Account Control (UAC), click **Yes** to allow the installer to make changes to your device.

4. The XMPro Stream Host Setup Wizard will appear. Click **Next** to continue.

   ![Stream Host Setup Wizard](../../images/Stream_Host_Windows_Setup_Wizard.png)

5. Read the License Agreement, select **I accept the terms in the license agreement**, and click **Next**.

6. Choose the installation folder or accept the default location, then click **Next**.

7. On the Connection Profile screen, click **Browse** and select the Connection Profile file you downloaded earlier.

   ![Connection Profile Selection](../../images/Stream_Host_Windows_Connection_Profile.png)

8. Enter the File Key that you used when downloading the Connection Profile, then click **Next**.

9. Review your installation settings and click **Install** to begin the installation process.

10. Once the installation is complete, click **Finish** to exit the setup wizard.

## Running as a Windows Service

The Stream Host is installed as a Windows Service and will start automatically after installation. You can manage the service through the Windows Services console:

1. Press **Win + R**, type `services.msc`, and press Enter.
2. Locate the service named **XMPro Stream Host**.
3. You can start, stop, or restart the service as needed.

![Windows Services Console](../../images/Stream_Host_Windows_Services.png)

## Verifying the Installation

To verify that the Stream Host is running correctly:

1. Log into Data Stream Designer.
2. Navigate to the Collections page.
3. Select the Collection you used in the Connection Profile.
4. The Stream Host should appear in the Devices list with a status of "Online".

![Stream Host Online Status](../../images/Stream_Host_Online_Status.png)

## Troubleshooting

If your Stream Host is not appearing in the Collection:

1. Check that the Windows Service is running.
2. Verify that the Connection Profile was correctly configured.
3. Ensure that the machine has internet access and can reach the XMPro server.
4. Check the Stream Host logs for any error messages:
   - Logs are stored in the installation directory under the `Logs` folder.
   - The default location is `C:\Program Files\XMPro\Stream Host\Logs`.
5. For more detailed troubleshooting, refer to the [Troubleshooting section](index.md#troubleshooting) in the main Stream Host documentation.

## Uninstalling

To uninstall the Stream Host:

1. Open the Windows Control Panel.
2. Go to **Programs and Features** (or **Apps & features** in Windows 10/11).
3. Find **XMPro Stream Host** in the list of installed programs.
4. Select it and click **Uninstall**.
5. Follow the prompts to complete the uninstallation process.
