# Run Stream Host as an Azure Web Job

This guide will walk you through the process of deploying the XMPro Stream Host as an Azure Web Job.

## Prerequisites

- An Azure subscription
- An existing Azure App Service or the ability to create one
- A valid [Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer

## Overview

Azure Web Jobs provide a way to run background processes in the context of an App Service. This is an ideal way to host the XMPro Stream Host in Azure, as it provides:

- Integration with Azure's infrastructure
- Automatic scaling capabilities
- Monitoring and logging through Application Insights
- Simplified deployment and management

## Deployment Steps

### 1. Prepare the Stream Host Package

1. [Download the Stream Host installer](index.md#download-the-installer) for Windows (x64) from Data Stream Designer.

2. Extract the contents of the installer to a local folder.

3. [Download the Connection Profile](index.md#download-the-connection-profile) from Data Stream Designer.

4. Create a file named `settings.job` in the same folder with the following content:

   ```json
   {
     "schedule": "0 */5 * * * *",
     "is_singleton": true
   }
   ```

   This configures the Web Job to run continuously and restart every 5 minutes if it stops.

5. Create a file named `run.cmd` in the same folder with the following content:

   ```cmd
   @echo off
   XMPro.StreamHost.exe
   ```

6. Create a file named `appsettings.json` in the same folder with the following content:

   ```json
   {
     "ConnectionProfile": {
       "Path": "D:\\home\\site\\wwwroot\\App_Data\\jobs\\continuous\\StreamHost\\connection-profile.json",
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

   Replace `your-file-key` with the key you used when downloading the Connection Profile.

7. Copy your Connection Profile file to the folder and rename it to `connection-profile.json`.

8. Create a ZIP file containing all the files in the folder.

### 2. Create an Azure App Service

If you don't already have an App Service, you'll need to create one:

1. Log in to the [Azure Portal](https://portal.azure.com).

2. Click on **Create a resource** > **Web** > **Web App**.

3. Configure the Web App:
   - **Subscription**: Select your Azure subscription
   - **Resource Group**: Create a new one or select an existing one
   - **Name**: Enter a unique name for your App Service
   - **Publish**: Code
   - **Runtime stack**: .NET Core 3.1
   - **Operating System**: Windows
   - **Region**: Select a region close to your XMPro server
   - **App Service Plan**: Create a new one or select an existing one

4. Click **Review + create**, then **Create**.

5. Wait for the deployment to complete.

### 3. Deploy the Stream Host as a Web Job

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **WebJobs**.

3. Click **Add**.

4. Configure the Web Job:
   - **Name**: StreamHost
   - **File Upload**: Select the ZIP file you created earlier
   - **Type**: Continuous

5. Click **OK** to create the Web Job.

6. The Web Job will start automatically. You can monitor its status in the WebJobs list.

## Configuring Application Settings

For better security, you can store sensitive information like the File Key in the App Service's Application Settings:

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **Configuration**.

3. Under the **Application settings** tab, click **New application setting**.

4. Add a setting:
   - **Name**: CONNECTION_PROFILE_FILE_KEY
   - **Value**: Your file key

5. Click **OK**, then **Save**.

6. Update your `appsettings.json` file to use this environment variable:

   ```json
   {
     "ConnectionProfile": {
       "Path": "D:\\home\\site\\wwwroot\\App_Data\\jobs\\continuous\\StreamHost\\connection-profile.json",
       "FileKey": "%CONNECTION_PROFILE_FILE_KEY%"
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

7. Re-create the ZIP file and redeploy the Web Job.

## Monitoring and Logging

You can monitor the Stream Host Web Job using the Azure Portal:

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **WebJobs**.

3. Click on the **StreamHost** Web Job.

4. Click on **Logs** to view the Web Job logs.

For more detailed logging, you can set up Application Insights:

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **Application Insights**.

3. Click **Turn on Application Insights**.

4. Configure Application Insights and click **Apply**.

5. Once configured, you can view detailed telemetry in the Application Insights resource.

## Verifying the Installation

To verify that the Stream Host is running correctly:

1. Check the Web Job status in the Azure Portal. It should show as "Running".

2. Check the Web Job logs for any error messages.

3. Log into Data Stream Designer, navigate to the Collections page, and select the Collection you used in the Connection Profile. The Stream Host should appear in the Devices list with a status of "Online".

## Troubleshooting

If your Stream Host is not appearing in the Collection:

1. Check the Web Job logs for any error messages.

2. Verify that the Connection Profile was correctly configured.

3. Ensure that the App Service has outbound internet access and can reach the XMPro server.

4. Check if the Web Job is running. If it's stopped, start it manually.

5. For more detailed troubleshooting, refer to the [Troubleshooting section](index.md#troubleshooting) in the main Stream Host documentation.

## Scaling

One of the advantages of running the Stream Host as an Azure Web Job is the ability to scale:

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **Scale up (App Service plan)** to change the VM size.

3. Alternatively, click on **Scale out (App Service plan)** to configure auto-scaling based on metrics like CPU usage.

## Uninstalling

To remove the Stream Host Web Job:

1. In the Azure Portal, navigate to your App Service.

2. In the left menu, under **Settings**, click on **WebJobs**.

3. Select the **StreamHost** Web Job.

4. Click **Delete** and confirm the deletion.
