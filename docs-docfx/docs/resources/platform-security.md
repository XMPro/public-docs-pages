# Platform Security

XMPro takes security seriously and provides a comprehensive set of security features to protect your data and applications.

## Authentication and Authorization

### Authentication

XMPro supports the following authentication methods:

- **Forms Authentication**: Username and password authentication.
- **Single Sign-On (SSO)**: Integration with identity providers using SAML 2.0, including:
  - Azure Active Directory
  - Active Directory Federation Services (ADFS)
  - Okta
  - Auth0

### Authorization

XMPro provides a role-based access control (RBAC) system that allows you to control access to resources based on user roles. The following roles are available:

- **Administrator**: Full access to all features and resources.
- **Designer**: Access to design features, including Data Stream Designer and App Designer.
- **User**: Access to published applications and dashboards.

Custom roles can be created with specific permissions to meet your organization's requirements.

## Data Security

### Data Encryption

XMPro encrypts sensitive data using industry-standard encryption algorithms:

- **Data in Transit**: All communication between XMPro components and clients is encrypted using TLS 1.2 or higher.
- **Data at Rest**: Sensitive data stored in the database is encrypted using AES-256 encryption.

### Database Security

XMPro supports the following database security features:

- **SQL Server Authentication**: Username and password authentication for SQL Server.
- **Windows Authentication**: Integrated Windows authentication for SQL Server.
- **Transparent Data Encryption (TDE)**: Encryption of the entire database at the file level.
- **Always Encrypted**: Column-level encryption for sensitive data.

## Network Security

### Firewall Configuration

XMPro components communicate over specific ports that can be configured to comply with your organization's firewall policies:

- **Web Application**: HTTPS (port 443)
- **Stream Host**: TCP (configurable port, default 8085)
- **Database**: SQL Server (port 1433)

### Reverse Proxy

XMPro can be deployed behind a reverse proxy to provide additional security features, such as:

- **Web Application Firewall (WAF)**: Protection against common web application attacks.
- **DDoS Protection**: Protection against distributed denial-of-service attacks.
- **IP Filtering**: Restriction of access to specific IP addresses or ranges.

## Application Security

### Input Validation

XMPro validates all user input to prevent common security vulnerabilities, such as:

- **SQL Injection**: Validation of SQL queries to prevent injection attacks.
- **Cross-Site Scripting (XSS)**: Encoding of user input to prevent script injection.
- **Cross-Site Request Forgery (CSRF)**: Use of anti-forgery tokens to prevent CSRF attacks.

### Secure Development

XMPro follows secure development practices, including:

- **Code Reviews**: All code is reviewed for security vulnerabilities.
- **Static Code Analysis**: Automated tools are used to identify potential security issues.
- **Penetration Testing**: Regular penetration testing is performed to identify and address security vulnerabilities.

## Compliance

XMPro is designed to help you meet your compliance requirements, including:

- **GDPR**: Support for data protection and privacy requirements.
- **HIPAA**: Support for healthcare data security and privacy requirements.
- **SOC 2**: Support for security, availability, and confidentiality requirements.

## Security Best Practices

### Password Policies

XMPro supports the following password policies:

- **Password Complexity**: Requirements for password length, character types, and complexity.
- **Password Expiration**: Automatic expiration of passwords after a configurable period.
- **Account Lockout**: Automatic lockout of accounts after a configurable number of failed login attempts.

### Audit Logging

XMPro provides comprehensive audit logging to track user activities and system events:

- **User Activities**: Logging of user login, logout, and access to resources.
- **System Events**: Logging of system startup, shutdown, and configuration changes.
- **Security Events**: Logging of security-related events, such as failed login attempts and access violations.

### Security Monitoring

XMPro provides tools for monitoring security events and detecting potential security incidents:

- **Real-Time Monitoring**: Monitoring of security events in real-time.
- **Alerting**: Notification of security events via email, SMS, or other channels.
- **Reporting**: Generation of security reports for compliance and audit purposes.

## Security Updates

XMPro regularly releases security updates to address potential vulnerabilities. It is recommended to keep your XMPro deployment up to date with the latest security patches.

For more information on security updates, see the [Release Notes](../release-notes/index.md) section.
