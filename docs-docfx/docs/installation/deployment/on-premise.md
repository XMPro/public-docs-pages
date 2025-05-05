# On-Premise

This document will guide you through how to deploy the XMPro Platform in an on-premise environment.

* [Install](#install)
* [Upgrade](#upgrade-xmpro)

## Architecture

The following deployment diagram shows an example on-premise architecture and the necessary resources for the XMPro platform in Microsoft Windows.

![Example XMPro architecture in Windows On-Premise](../images/Windows_Architecture.png)

## Prerequisites

In order to proceed with the deployment, you are required to:

1. Complete the steps in the **1. Preparation** guide:
   1. Meet the [**hardware** requirements](../index.md#hardware-requirements)
   2. Install the [**software** requirements](../index.md#software-requirements)
   3. Follow the [certificate and communication steps](../index.md#preparation-steps)
2. Enable Active Scripting and Allow Scriptlets \
   (so App Designer and Data Stream installers can authenticate with Subscription Manager)
   1. Open Internet Explorer.
   2. Open Tools.
   3. Open Internet Options.
   4. Switch to the Security tab.
   5. Click the "Custom level..." button.
   6. Find and enable Active Scriptlets under ActiveX controls and plug-ins.
   7. Find and enable Active Scripting under Scripting.
3. For Windows Server, disable these Internet Explorer settings\
   (so App Designer and Data Stream installers can authenticate with Subscription Manager)
   1. Open Server Manager.
   2. Click on Local Server from the left menu.
   3. Find the IE Enhanced Security Configuration on the right side and click on the "On" value.
   4. On the pop-up, select "Off" for Administrators and apply the changes.
4. Install IIS Service on a fresh Virtual Machine (VM)
   1. Open Server Manager.
   2. Click on Manage from the top right menu.
   3. Select Add Roles and Features, and click Next until you see Server Roles highlighted on the left.
   4. With Server Roles highlighted on the left, tick the _Web Server (IIS)_ role...
   5. Expand Web Server and Common HTTP Features, untick WebDAV Publishing, and click Next.\
      ![](../images/Install_On-Prem_IIS.png)
   6. With Features highlighted on the left, tick everything under the .NET Framework features.
   7. Click Next twice.
   8. With Role Services highlighted on the left, tick everything **except** _CGI_ under the _Application Development_ section.
   9. Click Next and Install.
   10. Go to the Start button and Administrative Tools to confirm IIS Manager was installed.

> [!NOTE]
> Please contact your XMPro account manager or [**XMPro support**](https://xmpro.com/support/) to request the installers.

## Install

## Subscription Manager

1. Start the installation process by running the _Subscription Manager.exe_ file, received from your Global Administrator.

![](../images/image_279.png)

2. Click the "I Agree" button and press "Next"

![](../images/image_1069.png)

3. Follow the instructions and when the installation is finished click "Close"

![](../images/image_467.png)

> [!NOTE]
> This "Setup" will install the installer you will use to install the database and website

4. When this initial installation is complete, open the start menu
5. Search for "XMPro Subscription Manager" and click on Run as Administrator

![](../images/image_1797.png)

### **Component Choice**

6. When the installer launches, choose "Install" and click "Next"

![](../images/image_1288.png)

7. Select the components that you would like to install and click "Next"

> [!NOTE]
> If this is the first time you are installing Subscription Manager, it is highly recommended that you select both "Database" and "Web Application"

![](../images/image_1357.png)

### Database

#### **Server**

8. Select the server instance to which you would like to connect

> [!NOTE]
> If you already know the server instance name, it can be entered manually. Otherwise, use the refresh button on the right to load all available servers. Selecting the "Local Servers" check box will limit the search to the local network.

![](../images/image_1626.png)

#### **Authentication Method**

9. Specify the authentication method that should be used: Windows or SQL

   9.1. Windows Authentication: you may leave the options as is

> [!WARNING]
> Configure a service account that can be used for Windows authentication.

   9.2. SQL authentication:

* Click the "Change" button
* Select the "Use SQL Authentication" option
* Enter the username and password of the SQL Server instance you're connecting to

> [!WARNING]
> The SQL user must have permission to create databases on the server.

![](../images/image_1377.png)

**Database**

> [!NOTE]
> The Database section allows you to configure if you would like to use an existing database or create a new one. Leaving the options as default will result in a new database being created.

To change the pre-populated name of the new database or to select to use an existing database:

10. Click the "Change" button
11. Make the changes needed by selecting the correct option
12. Specify the name of the new database or select an existing database from the drop-down

![](../images/image_1144.png)

### Web Application

**DNS Name**

13. Verify if your DNS name is correct, if not, edit the value to contain the correct DNS name

> [!NOTE]
> This is your fully qualified domain name (FQDN). Please find some examples below explaining the DNS name.
>
> * https://localhost/xmprosubscriptionmanager
> * https://desktop-f64k32e/xmprosubscriptionmanager
> * https://demo.azurewebsites.com

| Complete Address                                 | DNS                     | Virtual Directory                       |
| ------------------------------------------------ | ----------------------- | --------------------------------------- |
| https://localhost/xmprosubscriptionmanager       | <p></p><p>localhost</p> | <p></p><p>xmprosubscriptionmanager </p> |
| https://desktop-f64k32e/xmprosubscriptionmanager | desktop-f64k32e         | xmprosubscriptionmanager                |
| https://demo.azurewebsites.com                   | demo.azurewebsites.com  |                                         |

**Virtual Directory**

14. Select the parent site from the Web Site drop-down

> [!NOTE]
> By default, the Virtual Directory name will be "xmprosubscriptionmanager" which will be created within IIS for the Subscription Manager site. If you wish to change the name you can specify it in the "Virtual Directory Name" text box.

15. Verify if the value in the content directory field is correct. If not, apply any changes needed

> [!NOTE]
> By default, the option to create a sub-directory within the content directory is checked and you can specify a name in the "Sub-Directory" text box.

#### **Application Pool**

16. If you wish to change this name or use an existing application pool, click the Change button

> [!NOTE]
> By default, a new application pool will be created when installing the site. The new application pool will have the same name as the name specified in the "Application Pool Name" field.

17. Either select the "Create a new Application Pool" or "Use an existing Application Pool" option

> [!NOTE]
> If you choose "Create a new Application Pool", give it an appropriate name. If you choose "Use an existing Application Pool", select an existing application pool from the drop-down.

![](../images/image_12.png)

#### **Security Account**

18. Select a security account that can be used

> [!NOTE]
> The default option is "Local System", which is a built-in security account. You can either change it by selecting a different built-in security account from the drop-down or by specifying your own security account.

![](../images/image_1258.png)

> [!WARNING]
> If you selected Windows authentication to connect to the database, you must choose "Specify your own Security Account" and provide the correct credentials. The service account must have batch logon rights enabled. More Information on how to set up a custom application pool in IIS as well as steps on how to enable batch logon rights can be found in this [**link**](https://docs.xmpro.com/knowledge-base-2/setting-up-a-custom-application-pool-so-that-windows-authentication-can-be-used-when-installing-xmpro-enabling-batch-logon-rights-for-a-user/).

### SMTP

19. Enter the SMTP details referenced in the [**1. Preparation**](../index.md#smtp-account) guide. \
    By default, the "Enable Email Notification" is checked.

> [!NOTE]
> SMTP can be disabled by unchecking the "Enable Email Notification" checkbox if you don't want to receive email notifications. If at a later stage email notifications are needed, the installer can be run again to add SMTP functionality.

![](../images/image_1381.png)

> [!WARNING]
> You are required to set up an SMTP account. Failing to do so will make registering new users very cumbersome.
>
> Check your connection to the email server using the "Test SMTP settings" button.

### Certificates

During the installation process, you will be asked to upload two certificates: a signing certificate and an encryption certificate. You may use the same certificate for both options. The instructions on how to create a certificate can be found in the [**1. Preparation**](../index.md) guide.

#### **Signing Certificate**

20. Start by browsing to a suitable _.pfx_ certificate file. Specify the password for the certificate
21. Use the dropdown to select "Subject Name"

> [!NOTE]
> It is recommended that you choose "LocalMachine" as the Location for the signing certificate.

![](../images/image_356.png)

#### **Encryption Certificate**

22. Start by browsing to a suitable _.pfx_ certificate file. Specify the password for the certificate
23. Use the dropdown to select "Subject Name"

> [!NOTE]
> It is recommended that you choose "LocalMachine" as the Location for the encryption certificate.

![](../images/image_1431.png)

> [!WARNING]
> Both certificates must contain a private key.

### Final Steps

24. Continue through the wizard, confirm the installation and the components will be installed

![](../images/image_1658.png)

> [!WARNING]
> Note the username and password on the last screen of the installer. This user has been created during installation as Subscription Manager itself needs at least one user in the system. Without it, you cannot add other users.
>
> Change the password of the default user to a new, secure password after logging in for the first time.

### Accessing the Website

#### **Using Web Browser**

25. Access the website by putting the URL into your browser

> [!NOTE]
> The format of the URL will be as follows: "_https://yourdnsname/virtualdirectoryname/_"

![](../images/image_1728.png)

### Obtaining an Installation Profile

To install the Data Stream Designer and App Designer, you will need an Installation Profile.

26. Navigate to the XMPro Subscription Manager site as above
27. Go to the Subscription Manager page

![](../images/Home_Image_Current.jpg)

28. Click Products in the menu and click the Installation Profile button

![](../images/image_179.png)

29. Enter a File Key and press OK to download the file

> [!WARNING]
> Remember the file key as it is needed when installing Data Stream Designer and App Designer.

![](../images/image_1020.png)

### Optional: IIS User Permissions

If you've chosen to use a **custom service account** during installation, you may have to perform an extra step. An error may be shown after logging into Subscription Manager, even after giving the _IIS\_USRS_ group permission on the signing certificate private keys. The error would be as follow: "_We could not grant you access to the requested subscription. There was an unexpected error_". The logs would also contain the following error: "_System.Security.Cryptography.CryptographicException: Keyset does not exist_".

To solve this issue, use this [**article**](https://docs.xmpro.com/knowledge-base-2/how-to-grant-permission-to-iis-user-on-xmpro-identity-service-signing-certificate/) as a guideline to grant access for the Application Pool Identity (in some cases a domain account) on the signing certificate private keys.

## Data Stream Designer

1. Start the installation process by running the _Data Stream Designer.exe_ that you've received from your Global Administrator.

![](../images/image_1624.png)

2. Click the "I Agree" button and press "Next"​

![](../images/image_970.png)

3. Follow the instructions and when the installation is finished click "Close"

![](../images/image_1463.png)

4. When this initial installation is complete, open the start menu
5. Search for "Data Stream Designer" and click on Run as Administrator

![](../images/image_907.png)

### Component Choice

6. When the installer launches, choose "Install"

![](../images/image_815.png)

7. Select the components that you would like to install

> [!NOTE]
> If this is the first time you are installing the Data Stream Designer, it is highly recommended that you select both "Database" and "Web Application".

![](../images/image_120.png)

### Database

#### **Server**

8. Select the server instance you would like to connect to.

> [!NOTE]
> If you already know the server instance name, it can be entered manually. Otherwise, use the refresh button on the right to load all available servers. Selecting the "Local Servers" check box will limit the search to the local network.

![](../images/image_927.png)

#### **Authentication Method**

9. Specify the authentication method that should be used: Windows or SQL

   9.1. Windows Authentication: you may leave the options as is

> [!WARNING]
> Configure a service account that can be used for Windows authentication.

   9.2. SQL Authentication:

* To connect to the database using SQL Server authentication, click the "Change" button
* Select the "Use SQL Authentication" option
* Enter the username and password of the SQL Server instance you're connecting to

> [!WARNING]
> The SQL user must have permission to create databases on the server.

![](../images/image_1243.png)

**Database**

> [!NOTE]
> The Database section allows you to configure if you would like to use an existing database or create a new one. Leaving the options as default will result in a new database being created.

To change the pre-populated name of the new database or to select to use an existing database:

10. Click the "Change" button and select the appropriate option
11. Specify the name of the new database or select an existing database from the drop-down

![](../images/image_62.png)

### Encryption Upgrade

If you are upgrading from 4.0 to 4.1 or greater, you will be shown the Encryption Upgrade Settings page. This will assist you in migrating existing Server Variables to the new method of encryption.

> [!WARNING]
> To upgrade existing Server Variables, the details of the **Subscription Manager** database are required, **not** the **Data Stream Designer** database (provided on the previous page).

#### Upgrade Server Variables?

12. Tick to automatically upgrade the Server Variables. It is recommended, but not required. \
    None of the other settings on this page are required if you choose not to upgrade.

![](../images/DSD_Encryption_Upgrade_1.png)

#### Server

13. Select the server instance you want to connect to

#### Authentication Method

14. Specify the authentication method that should be used: Windows or SQL

#### Database

15. Select the **Subscription Manager** database and click Next

### Web Application

**DNS Name**

16. Verify if your DNS name is correct. If not, edit the value to contain the correct DNS name

> [!NOTE]
> This is your fully qualified domain name (FQDN). Please find some examples below explaining the DNS name.
>
> * https://localhost/xmprosubscriptionmanager
> * https://desktop-f64k32e/xmprosubscriptionmanager
> * https://demo.azurewebsites.com

| Complete Address                                 | DNS                     | Virtual Directory                       |
| ------------------------------------------------ | ----------------------- | --------------------------------------- |
| https://localhost/xmprosubscriptionmanager       | <p></p><p>localhost</p> | <p></p><p>xmprosubscriptionmanager </p> |
| https://desktop-f64k32e/xmprosubscriptionmanager | desktop-f64k32e         | xmprosubscriptionmanager                |
| https://demo.azurewebsites.com                   | demo.azurewebsites.com  |                                         |

**Virtual Directory**

17. Select the parent site from the Web Site drop-down

> [!NOTE]
> By default, the Virtual Directory name will be "DataStreams" which will be created within IIS for the Data Stream site. If you wish to change the name you can specify it in the "Virtual Directory Name" text box.

18. Verify the value in the content directory field. If incorrect, apply any changes needed

> [!NOTE]
> By default, the option to create a sub-directory within the content directory is checked and you can specify a name in the "Sub-Directory" text box.

#### Application Pool

19. If you wish to change the name or use an existing application pool, click the Change button

> [!NOTE]
> By default, a new application pool will be created when installing the site. The new application pool will have the same name as the name specified in the "Application Pool Name" field.

20. Either select the "Create a new Application Pool" or "Use an existing Application Pool" option

> [!NOTE]
> If you choose "Create a new Application Pool", give it an appropriate name. If you choose "Use an existing Application Pool", select an existing application pool from the drop-down.

![](../images/image_506.png)

#### **Security Account**

21. Select "Local System" as the security account.

> [!NOTE]
> The two options available to choose from are using a built-in security account or specifying your own security account.

![](../images/DS_LocalSystem.png)

> [!WARNING]
> If you selected Windows authentication to connect to the database, you must choose "Specify your own Security Account" and provide the correct credentials. The service account must have batch logon rights enabled. More Information on how to set up a custom application pool in IIS as well as steps on how to enable batch logon rights can be found in this [**link**](https://docs.xmpro.com/knowledge-base-2/setting-up-a-custom-application-pool-so-that-windows-authentication-can-be-used-when-installing-xmpro-enabling-batch-logon-rights-for-a-user/).

### Installation Profile

22. Click the Browse button to upload an installation profile for Subscription Manager
23. Select a file and click "Next"

> [!NOTE]
> This file ensures the Data Stream Designer contains the correct details for the Subscription Manager instance you would like to use. The file can be obtained through the [steps outlined previously in this tutorial](#obtaining-an-installation-profile).

![](../images/image_1723.png)

24. After you press "Next", authenticate yourself using Subscription Manager credentials

![](../images/image_766.png)

> [!WARNING]
> If you are unable to sign in at this step, please follow this [**link**](https://docs.microsoft.com/en-us/troubleshoot/browsers/enhanced-security-configuration-faq#how-to-turn-off-internet-explorer-esc-on-windows-servers) to disable Internet Explorer Enhanced Security Configuration.

### Final Steps

25. Continue through the wizard, confirm the installation and the components will be installed

## App Designer

1. Start the installation process by running the _App Designer.exe_ file that you've received from your Global Administrator.

![](../images/image_1631.png)

2. Click the "I Agree" button and press "Next"

![](../images/image_189.png)

3. Follow the instructions and click "Close" when the installation is finished

![](../images/image_869.png)

> [!NOTE]
> This "Setup" will install the installer you will use to install the database and website

4. When this initial installation is complete, open the start menu
5. Search for "App Designer" and click on Run as Administrator

![](../images/image_222.png)

### **Component Choice**

6. When the installer launches, choose "Install" and click "Next"

![](../images/image_1438.png)

7. Select the components that you would like to install and click "Next"

> [!NOTE]
> If this is the first time you are installing Subscription Manager, it is highly recommended that you select both "Database" and "Web Application".

![](../images/image_323.png)

### Database

#### **Server**

8. Select the server instance you would like to connect to

> [!NOTE]
> If you already know the server instance name, it can be entered manually. Otherwise, use the refresh button on the right to load all available servers. Selecting the "Local Servers" check box will limit the search to the local network.

![](../images/image_891.png)

#### **Authentication Method**

9. Specify the authentication method that should be used: Windows or SQL

   9.1. Windows Authentication: you may leave the options as is

> [!WARNING]
> Configure a service account that can be used for Windows authentication

   9.2. SQL Authentication:

* Click the "Change" button
* Select the "Use SQL Authentication" option
* Enter the username and password of the SQL Server instance you're connecting to

> [!WARNING]
> The SQL user must have permission to create databases on the server.

![](../images/image_1307.png)

**Database**

> [!NOTE]
> The Database section allows you to configure if you would like to use an existing database or create a new one. Leaving the options as default will result in a new database being created.

To change the pre-populated name of the new database or to select to use an existing database:

10. Click the "Change" button and select the appropriate option
11. Specify the name of the new database or select an existing database from the drop-down

![](../images/image_131.png)

### Encryption Upgrade

If you are upgrading from 4.0 to 4.1 or greater, you will be shown the Encryption Upgrade Settings page. This will assist you in migrating existing Server Variables and Connector settings to the new method of encryption.

> [!WARNING]
> To upgrade existing Server Variables, the details of the **Subscription Manager** database is required, **not** the **Data Stream Designer** database (provided on the previous page).

#### App Designer Encryption Key

12. Enter the App Designer Encryption Key

> [!NOTE]
> To find the App Designer Encryption Key, inspect the appsettings.json file in the web server files. It will be found under the JSON path "xmpro.appDesigner.encryptionKey".
>
> If that path does not exist, it is stored in a cloud-service key vault. Search for the "xmpro.keyVault" JSON object for the details required to find the encryption key.
>
> Documentation for the [Azure](#server) and [Amazon](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html) key vaults have been linked for convenience.

![](../images/AD_Encryption_Upgrade_1.png)

#### Upgrade Server Variables?

13. Tick to automatically upgrade the Server Variables. It is recommended, but not required. \
    None of the other settings on this page are required if you choose not to upgrade.

#### Server

14. Select the server instance you want to connect to

#### Authentication Method

15. Specify the authentication method that should be used: Windows or SQL

#### Database

16. Select the **Subscription Manager** database and click Next

### Web Application

**DNS Name**

17. Verify if your DNS name is correct, if not, edit the value to contain the correct DNS name

> [!NOTE]
> This is your fully qualified domain name (FQDN). Please find some examples below explaining the DNS name.
>
> * https://localhost/xmprosubscriptionmanager
> * https://desktop-f64k32e/xmprosubscriptionmanager
> * https://demo.azurewebsites.com

| https://localhost/xmprosubscriptionmanager       | <p></p><p>localhost</p> | <p></p><p>xmprosubscriptionmanager </p> |
| ------------------------------------------------ | ----------------------- | --------------------------------------- |
| https://desktop-f64k32e/xmprosubscriptionmanager | desktop-f64k32e         | xmprosubscriptionmanager                |
| https://demo.azurewebsites.com                   | demo.azurewebsites.com  |                                         |

**Virtual Directory**

18. Select the parent site from the Web Site drop-down

> [!NOTE]
> By default, the Virtual Directory name will be "AppDesigner" which will be created within IIS for the Data Stream site. If you wish to change the name you can specify it in the "Virtual Directory Name" text box.

19. Verify if the value in the content directory field is correct. If not, apply any changes needed

> [!NOTE]
> By default, the option to create a sub-directory within the content directory is checked and you can specify a name in the "Sub-Directory" text box.

#### **Application Pool**

20. If you wish to change this name or use an existing application pool, click the Change button

> [!NOTE]
> By default, a new application pool will be created when installing the site. The new application pool will have the same name as the name specified in the "Application Pool Name" field.

21. Either select the "Create a new Application Pool" or "Use an existing Application Pool" option

> [!NOTE]
> If you choose "Create a new Application Pool", give it an appropriate name. If you choose "Use an existing Application Pool", select an existing application pool from the drop-down.

![](../images/image_830.png)

#### **Security Account**

22. Select "Local System" as the security account

> [!NOTE]
> You can either change it by selecting a different built-in security account from the drop-down or by specifying your own security account.

![](../images/AD_LocalSystem.png)

> [!WARNING]
> If you selected Windows authentication to connect to the database, you must choose "Specify your own Security Account" and provide the correct credentials. The service account must have batch logon rights enabled. More Information on how to set up a custom application pool in IIS as well as steps on how to enable batch logon rights can be found in this [**link**](https://docs.xmpro.com/knowledge-base-2/setting-up-a-custom-application-pool-so-that-windows-authentication-can-be-used-when-installing-xmpro-enabling-batch-logon-rights-for-a-user/).

### Integration Details

23. Type in the URL of Data Stream designer in the text box

![](../images/image_1042.png)

### SMTP

24. Enter the SMTP settings referenced in the [**1. Preparation**](../index.md#smtp-account) guide. \
    By default, the "Enable Email Notification" is checked.

> [!NOTE]
> SMTP can be disabled by unchecking the "Enable Email Notification" checkbox if you don't want to receive email notifications. If at a later stage email notifications are needed, the installer can be run again to add SMTP functionality.

![](../images/image_164.png)

> [!WARNING]
> You are required to set up an SMTP account. Failing to do so will make registering new users very cumbersome.
>
> It is highly recommended to check your connection to the email server using the "Test SMTP settings" button.

### Twilio (Optional)

25. Enter the Twilio details referenced in the [**1. Preparation**](../index.md#twilio-optional) guide. If you don't want SMS notifications you can select "None" from the "Select Provider" dropdown.

![](../images/image_51.png)

### Installation Profile

26. Click the Browse button to upload an installation profile for Subscription Manager
27. Select a file and click "Next"

> [!NOTE]
> This file ensures the App Designer contains the correct details for the Subscription Manager instance you would like to use. The file used can be obtained through the [steps outlined previously in this tutorial](#obtaining-an-installation-profile).
>
> The Installation Profile generated for Data Stream Installer can be used in this step.

![](../images/image_507.png)

28. After you press "Next", authenticate yourself using Subscription Manager credentials

![](../images/image_412.png)

> [!WARNING]
> If you are unable to sign in at this step, please follow this [**link**](https://docs.microsoft.com/en-us/troubleshoot/browsers/enhanced-security-configuration-faq#how-to-turn-off-internet-explorer-esc-on-windows-servers) to disable Internet Explorer Enhanced Security Configuration.

### Final Steps

29. Continue through the wizard, confirm the installation and the components will be installed

## Next Step: Complete Installation

The installation of the XMPro Platform is now complete, but there are some environment setup steps before you can use the platform. Please click the below link for further instructions:

[Complete Installation](../complete-installation/index.md)

## Upgrade XMPro

It is necessary to first uninstall the installers on the host server before proceeding with the upgrade installers. Once you have removed the installers, the procedure for the upgrade is the same as the original install.

This section aims to provide step-by-step instructions on how to safely uninstall only the XMPro installers and not the on-premises deployed XMPro solution.

The process of uninstalling the XMPro installer must be repeated for each application individually. The steps are the same for each application installer and the sequence is not significant.

### Uninstall Subscription Manager Installer

1. Log on to the instance where the XMPro installers are installed.
2. From the start menu select XMPro Subscription Manager and right-click it.
3. Click Uninstall.
4. Select XMPro Subscription Manager from the list of programs displayed.
5. Click Uninstall.
6. When prompted to confirm uninstall click Yes.
7. Click Next.

![](../images/image_1196.png)

8. When prompted to select the install to modify click Cancel. \
   **We do not want to remove the installed XMPro site, only the installer.**

![](../images/image_1196.png)
